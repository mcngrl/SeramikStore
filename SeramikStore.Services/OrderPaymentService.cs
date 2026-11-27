using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public class OrderPaymentInfo
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public decimal Price { get; set; }
        public string Status { get; set; } = "";
    }

    public interface IOrderPaymentService
    {
        void AddInitiated(int orderId, string token, decimal price, string currencyCode);
        OrderPaymentInfo? GetByToken(string token);
        bool IsOrderPaid(int orderId);
        /// <summary>Sadece "Initiated" kaydı sonuçlandırır. İlk çağrıda true, tekrar çağrılarda false döner.</summary>
        bool Complete(string token, bool success, string? paymentId, decimal? paidPrice, string? errorCode, string? errorMessage);
    }

    public class OrderPaymentService : IOrderPaymentService
    {
        private readonly string _cs;

        public OrderPaymentService(IConfiguration config)
        {
            _cs = config.GetConnectionString("DefaultConnection")!;
        }

        public void AddInitiated(int orderId, string token, decimal price, string currencyCode)
        {
            using var conn = new SqlConnection(_cs);
            using var cmd = new SqlCommand(
                @"INSERT INTO OrderPayment (OrderId, Token, Price, CurrencyCode, Status)
                  VALUES (@OrderId, @Token, @Price, @Cur, 'Initiated')", conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@Token", token);
            cmd.Parameters.AddWithValue("@Price", price);
            cmd.Parameters.AddWithValue("@Cur", (object?)currencyCode ?? DBNull.Value);
            conn.Open();
            cmd.ExecuteNonQuery();
        }

        public OrderPaymentInfo? GetByToken(string token)
        {
            using var conn = new SqlConnection(_cs);
            using var cmd = new SqlCommand(
                @"SELECT p.OrderId, h.UserId, p.Price, p.Status
                  FROM OrderPayment p
                  INNER JOIN OrderHeader h ON h.Id = p.OrderId
                  WHERE p.Token = @Token", conn);
            cmd.Parameters.AddWithValue("@Token", token);
            conn.Open();
            using var r = cmd.ExecuteReader();
            if (!r.Read()) return null;
            return new OrderPaymentInfo
            {
                OrderId = Convert.ToInt32(r["OrderId"]),
                UserId = Convert.ToInt32(r["UserId"]),
                Price = Convert.ToDecimal(r["Price"]),
                Status = r["Status"].ToString() ?? ""
            };
        }

        public bool IsOrderPaid(int orderId)
        {
            using var conn = new SqlConnection(_cs);
            using var cmd = new SqlCommand(
                "SELECT COUNT(1) FROM OrderPayment WHERE OrderId = @OrderId AND Status = 'Success'", conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            conn.Open();
            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }

        public bool Complete(string token, bool success, string? paymentId, decimal? paidPrice, string? errorCode, string? errorMessage)
        {
            using var conn = new SqlConnection(_cs);
            using var cmd = new SqlCommand(
                @"UPDATE OrderPayment
                  SET Status = @Status, ProviderPaymentId = @PayId, PaidPrice = @Paid,
                      ErrorCode = @ErrCode, ErrorMessage = @ErrMsg, CompletedAt = GETDATE()
                  WHERE Token = @Token AND Status = 'Initiated'", conn);
            cmd.Parameters.AddWithValue("@Status", success ? "Success" : "Failed");
            cmd.Parameters.AddWithValue("@PayId", (object?)paymentId ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Paid", (object?)paidPrice ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ErrCode", (object?)errorCode ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ErrMsg", (object?)Trunc(errorMessage, 500) ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Token", token);
            conn.Open();
            return cmd.ExecuteNonQuery() > 0;
        }

        private static string? Trunc(string? s, int max) => s is { Length: > 0 } && s.Length > max ? s[..max] : s;
    }
}