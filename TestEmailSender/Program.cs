using System.Net;
using System.Net.Mail;

class Program
{
    static async Task Main(string[] args)
    {
        Console.WriteLine("=== SMTP Test Aracı ===\n");

        // Ayarlar
        var host = "mail5008.site4now.net";
        var port = 587;
        var ssl = true;
        var userName = "info@dibuceramic.com";
        var password = "Sanane1563!"; // gerçek şifreyi buraya yaz
        var fromName = "dibu ceramic";
        var from = "info@dibuceramic.com";

        Console.Write("Test emaili gönderilecek adres: ");
        var to = Console.ReadLine()?.Trim();

        if (string.IsNullOrEmpty(to))
        {
            Console.WriteLine("Geçersiz adres.");
            return;
        }

        Console.WriteLine($"\nBağlanılıyor: {host}:{port} (SSL: {ssl})");
        Console.WriteLine($"Gönderen: {from}");
        Console.WriteLine($"Alıcı: {to}");
        Console.WriteLine("Gönderiliyor...\n");

        try
        {
            using var message = new MailMessage
            {
                From = new MailAddress(from, fromName),
                Subject = $"SMTP Test - {DateTime.Now:dd.MM.yyyy HH:mm:ss}",
                Body = $@"
                    <h3>SMTP Test Emaili</h3>
                    <p>Bu email SmartASP.NET SMTP testi için gönderilmiştir.</p>
                    <p><strong>Sunucu:</strong> {host}:{port}</p>
                    <p><strong>Tarih:</strong> {DateTime.Now:dd.MM.yyyy HH:mm:ss}</p>
                    <p>Bu emaili aldıysanız SMTP ayarları doğru çalışıyor demektir.</p>
                ",
                IsBodyHtml = true
            };
            message.To.Add(to);

            using var client = new SmtpClient(host, port)
            {
                Credentials = new NetworkCredential(userName, password),
                EnableSsl = ssl,
                Timeout = 30000
            };

            var stopwatch = System.Diagnostics.Stopwatch.StartNew();
            await client.SendMailAsync(message);
            stopwatch.Stop();

            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine($"✔ Email başarıyla gönderildi!");
            Console.WriteLine($"  Süre: {stopwatch.ElapsedMilliseconds} ms");
            Console.ResetColor();
        }
        catch (SmtpException ex)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"✘ SMTP Hatası!");
            Console.WriteLine($"  StatusCode : {ex.StatusCode}");
            Console.WriteLine($"  Message    : {ex.Message}");
            Console.WriteLine($"  Inner      : {ex.InnerException?.Message}");
            Console.ResetColor();
        }
        catch (Exception ex)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"✘ Genel Hata!");
            Console.WriteLine($"  Message : {ex.Message}");
            Console.WriteLine($"  Inner   : {ex.InnerException?.Message}");
            Console.ResetColor();
        }

        Console.WriteLine("\nÇıkmak için bir tuşa basın...");
        Console.ReadKey();
    }
}