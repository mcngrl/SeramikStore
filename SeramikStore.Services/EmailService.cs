using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Resend;
using System.Net;
using System.Net.Mail;
using System.Reflection;

namespace SeramikStore.Services.Email
{
    public class EmailService : IEmailService
    {
        private readonly EmailSettings _settings;
        private readonly IAppLogService _appLogService;

        public EmailService(IOptions<EmailSettings> settings, ILogger<EmailService> logger, IAppLogService appLogService)
        {
            _settings = settings.Value;
            _appLogService = appLogService;
        }

        public void Send(string to, string subject, string htmlBody)
        {
            var message = new MailMessage
            {
                From = new MailAddress(_settings.FromEmailAdress, _settings.FromName),
                Subject = subject,
                Body = htmlBody,
                IsBodyHtml = true
            };

            message.To.Add(to);

            var client = new SmtpClient(_settings.Host, _settings.Port)
            {
                Credentials = new NetworkCredential(
                    _settings.UserName,
                    _settings.Password
                ),
                EnableSsl = _settings.EnableSsl
            };

            client.Send(message);
        }

        public async Task SendAsyncOld(string to, string subject, string htmlBody)
        {
            try
            {
                using var message = new MailMessage
                {
                    From = new MailAddress(_settings.FromEmailAdress, _settings.FromName),
                    Subject = subject,
                    Body = htmlBody,
                    IsBodyHtml = true
                };

                message.To.Add(to);

                using var client = new SmtpClient(_settings.Host, _settings.Port)
                {
                    Credentials = new NetworkCredential(
                        _settings.UserName,
                        _settings.Password
                    ),
                    EnableSsl = _settings.EnableSsl,
                    Timeout = 30000 // ⬅️ 10 saniye timeout (çok önemli)
                };

                await client.SendMailAsync(message);

                await _appLogService.SuccessAsync("Email", "SendAsync",
                $"Email gönderildi. To: {to} | Subject: {subject}");
            }
            catch (Exception ex)
            {

                await _appLogService.ErrorAsync("Email", "SendAsync",
                      $"Email gönderilemedi. To: {to} | Subject: {subject}", ex);

                throw new Exception("Email gönderimi başarısız.", ex);
            }


        }

        public async Task SendAsync(string to, string subject, string htmlBody)
        {
            try
            {
                IResend resend = ResendClient.Create(_settings.ResendApi.ApiKey);
                var resp = await resend.EmailSendAsync(new EmailMessage()
                {
                    From = _settings.ResendApi.FromEmailAdress,
                    To = to,
                    Subject = subject,
                    HtmlBody = htmlBody,
                });

                await _appLogService.SuccessAsync("Email", "SendAsync", $"Email gönderildi. To: {to} | Subject: {subject} | Id: {resp.Content}");
                Console.WriteLine("Email Id={0}", resp.Content);
            }
            catch (Exception ex)
            {
                await _appLogService.ErrorAsync("Email", "SendAsync", $"Email gönderilemedi. To: {to} | Subject: {subject} | Hata: {ex.Message}");
                Console.WriteLine("Hata: {0}", ex.Message);
                throw;
            }
        }
    }
}
