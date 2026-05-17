using Azure;
using FirebaseAdmin.Messaging;
using Microsoft.AspNetCore.Http;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json.Linq;
using SeramikStore.Services;
using System.Data;
using static Google.Apis.Requests.BatchRequest;

public class NotificationService : INotificationService
{
    private readonly string _connectionString;
    private readonly IAppLogService _appLogService;

    public NotificationService(IConfiguration configuration, IAppLogService appLogService)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
        _appLogService = appLogService;
    }
    public async Task SendToAdmin(string title, string body)
    {
        var logDir = Path.Combine(Directory.GetCurrentDirectory(), "logs");
        Directory.CreateDirectory(logDir); // logs klasörü yoksa oluştur

        var tokens = new List<string>();
        using (SqlConnection con = new(_connectionString))
        using (SqlCommand cmd = new("sp_AdminFcmToken_GetAll", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                    tokens.Add(reader["Token"].ToString()!);
            }
        }
        await _appLogService.SuccessAsync("Notification", "SendToAdmin", $"SendToAdmin çalıştı. title:{title} body:{body}");

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
                var response = await FirebaseMessaging.DefaultInstance.SendAsync(message);

              

                await _appLogService.SuccessAsync("Notification", "SendToAdmin",
                $"Bildirim gönderildi. Token: {token.Substring(0, 20)}.{response.ToString()}");
            }
            catch (Exception ex)
            {
                await _appLogService.ErrorAsync("Notification", "SendToAdmin",
                    $"Bildirim gönderilemedi. Token: {token.Substring(0, 20)}",ex);

                if (ex.Message.Contains("unregistered") || ex.Message.Contains("invalid-registration-token"))
                {
                    using SqlConnection con = new(_connectionString);
                    using SqlCommand cmd = new("sp_AdminFcmToken_Delete", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Token", token);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}