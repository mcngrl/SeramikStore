using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public class FcmService : IFcmService
    {
        private readonly string _connectionString;

        public FcmService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public void SaveToken(string token, string userAgent, string deviceName, string userName)
        {
            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_AdminFcmToken_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Token", token);
            cmd.Parameters.AddWithValue("@UserAgent", userAgent ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@DeviceName", deviceName ?? (object)DBNull.Value);
            cmd.Parameters.AddWithValue("@UserName", userName ?? (object)DBNull.Value);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}
