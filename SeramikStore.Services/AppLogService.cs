using Microsoft.AspNetCore.Http;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Contracts.Admin;
using System.Data;
namespace SeramikStore.Services
{
    public class AppLogService : IAppLogService
    {
        private readonly string _connectionString;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public AppLogService(IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
            _httpContextAccessor = httpContextAccessor;
        }

        public Task InfoAsync(string module, string action, string message)
            => WriteAsync("INFO", module, action, message, null);

        public Task SuccessAsync(string module, string action, string message)
            => WriteAsync("SUCCESS", module, action, message, null);

        public Task WarningAsync(string module, string action, string message)
            => WriteAsync("WARNING", module, action, message, null);

        public Task ErrorAsync(string module, string action, string message,
                               Exception ex = null)
        {
            var exDetail = ex == null ? null :
                $"{ex.Message} | InnerException: {ex.InnerException?.Message} | StackTrace: {ex.StackTrace?.Substring(0, Math.Min(ex.StackTrace.Length, 2000))}";

            return WriteAsync("ERROR", module, action, message, exDetail);
        }

        private (int? userId, string userName, string ip) GetSessionInfo()
        {
            var context = _httpContextAccessor.HttpContext;
            if (context == null) return (null, null, null);

            var userId = context.Session.GetInt32("session_UserId");
            var userName = context.Session.GetString("session_Email");
            var ip = context.Connection.RemoteIpAddress?.ToString();

            return (userId, userName, ip);
        }

        private async Task WriteAsync(string logLevel, string module, string action,
                                       string message, string exception)
        {
            var (userId, userName, ip) = GetSessionInfo();

            try
            {
                using SqlConnection con = new(_connectionString);
                using SqlCommand cmd = new("sp_AppLog_Insert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@LogLevel", logLevel);
                cmd.Parameters.AddWithValue("@Module", module ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@Action", action ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@Message", message ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@Exception", exception ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@UserId", userId.HasValue ? userId.Value : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@UserName", userName ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@IpAddress", ip ?? (object)DBNull.Value);
                con.Open();
                await cmd.ExecuteNonQueryAsync();
            }
            catch
            {
                // Log yazma hatası uygulamayı durdurmasın
            }
        }

        public List<AppLogDto> GetRecent(int take = 200)
        {
            var logs = new List<AppLogDto>();

            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_AppLog_GetRecent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Take", take);
            con.Open();

            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                logs.Add(new AppLogDto
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    LogDate = Convert.ToDateTime(reader["LogDate"]),
                    LogLevel = reader["LogLevel"].ToString(),
                    Module = reader["Module"] == DBNull.Value ? null : reader["Module"].ToString(),
                    Action = reader["Action"] == DBNull.Value ? null : reader["Action"].ToString(),
                    Message = reader["Message"] == DBNull.Value ? null : reader["Message"].ToString(),
                    Exception = reader["Exception"] == DBNull.Value ? null : reader["Exception"].ToString(),
                    UserId = reader["UserId"] == DBNull.Value ? null : Convert.ToInt32(reader["UserId"]),
                    UserName = reader["UserName"] == DBNull.Value ? null : reader["UserName"].ToString(),
                    IpAddress = reader["IpAddress"] == DBNull.Value ? null : reader["IpAddress"].ToString()
                });
            }

            return logs;
        }
    }
}