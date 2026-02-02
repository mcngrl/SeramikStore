using Microsoft.Extensions.Options;
using System.Net;
using System.Net.Mail;

namespace SeramikStore.Services.Email
{
    public class EmailService : IEmailService
    {
        private readonly EmailSettings _settings;

        public EmailService(IOptions<EmailSettings> settings)
        {
            _settings = settings.Value;
        }

        public void Send(string to, string subject, string htmlBody)
        {
            var message = new MailMessage
            {
                From = new MailAddress(_settings.UserName, _settings.FromName),
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
    }
}
