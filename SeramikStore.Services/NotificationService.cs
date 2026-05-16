using FirebaseAdmin.Messaging;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Services;
using System.Data;

public class NotificationService : INotificationService
{
    private readonly string _connectionString;

    public NotificationService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    public async Task SendToAdmin(string title, string body)
    {
        var tokens = new List<string>();

        using (SqlConnection con = new(_connectionString))
        using (SqlCommand cmd = new("sp_AdminFcmToken_GetAll", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    tokens.Add(reader["Token"].ToString()!);
                }
            }
        }

        foreach (var token in tokens)
        {
            var message = new Message()
            {
                Token = token,
                Notification = new Notification
                {
                    Title = title,
                    Body = body
                
                },
                Android = new AndroidConfig
                {
                    Priority = Priority.High
                },
                Apns = new ApnsConfig
                {
                    Aps = new Aps { Sound = "default" }
                }
            };

            try
            {
                await FirebaseMessaging.DefaultInstance.SendAsync(message);

                //var response = await FirebaseMessaging.DefaultInstance.SendAsync(message);
                //Console.WriteLine("Firebase Response: " + response); // ← mesaj ID dönmeli
            }
            catch (Exception ex)
            {
                Console.WriteLine("Firebase Hata: " + ex.Message);
                throw; // geçici olarak ekle
            }
        }
    }
}