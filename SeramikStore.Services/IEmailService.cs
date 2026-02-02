namespace SeramikStore.Services.Email
{
    public interface IEmailService
    {
        void Send(string to, string subject, string htmlBody);
    }
}
