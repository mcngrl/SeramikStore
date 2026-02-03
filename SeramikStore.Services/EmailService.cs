using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Net;
using System.Net.Mail;
using System.Reflection;

namespace SeramikStore.Services.Email
{
    public class EmailService : IEmailService
    {
        private readonly EmailSettings _settings;
        private readonly ILogger<EmailService> _logger;

        public EmailService(IOptions<EmailSettings> settings,ILogger<EmailService> logger)
        {
            _settings = settings.Value;
            _logger = logger;
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

        public async Task SendAsync(string to, string subject, string htmlBody)
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
                    Timeout = 10000 // ⬅️ 10 saniye timeout (çok önemli)
                };

                await client.SendMailAsync(message);
            }
            catch (Exception ex)
            {

                _logger.LogError(ex,
                               $"Email gönderilemedi. To: {to}, Subject: {subject}",
                               to,
                               subject
                           );

                // 🔥 KRİTİK: exception fırlatmıyoruz → uygulama devam eder
            }


        }

    }
}
