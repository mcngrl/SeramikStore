using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Contracts.Return;
using SeramikStore.Services;
using System.Data;

public class ReturnService : IReturnService
{
    private readonly string _connectionString;

    public ReturnService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    public List<ReturnHeaderDto> GetReturnsByOrderId(int orderId)
    {
        var headers = new List<ReturnHeaderDto>();
        var details = new List<ReturnDetailDto>();

        using (var conn = new SqlConnection(_connectionString))
        using (var cmd = new SqlCommand("sp_Return_GetByOrderId", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OrderId", orderId);

            conn.Open();

            using (var reader = cmd.ExecuteReader())
            {
                // 1️⃣ HEADER
                while (reader.Read())
                {
                    headers.Add(new ReturnHeaderDto
                    {
                        Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        UserId = reader.GetInt32(reader.GetOrdinal("UserId")),
                        ReturnRequestDate = reader.GetDateTime(reader.GetOrdinal("ReturnRequestDate")),
                        OrderId = reader.GetInt32(reader.GetOrdinal("OrderId")),
                        Reason = reader["Reason"]?.ToString()
                    });
                }

                // 2️⃣ DETAIL
                if (reader.NextResult())
                {
                    while (reader.Read())
                    {
                        details.Add(new ReturnDetailDto
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            ReturnId = reader.GetInt32(reader.GetOrdinal("ReturnId")),
                            OrderDetailId = reader.GetInt32(reader.GetOrdinal("OrderDetailId")),

                            ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                            ReturnUnitPrice = reader.GetDecimal(reader.GetOrdinal("ReturnUnitPrice")),
                            ReturnQuantity = reader.GetInt32(reader.GetOrdinal("ReturnQuantity")),

                            OrderId = reader["OrderId"] as int?,
                            ProductCode = reader["ProductCode"]?.ToString(),
                            ProductName = reader["ProductName"]?.ToString(),
                            ProductDesc = reader["ProductDesc"]?.ToString(),
                            OrderUnitPrice = reader["OrderUnitPrice"] as decimal?,
                            Quantity = reader["Quantity"] as int?,
                            LineTotal = reader["LineTotal"] as decimal?,
                            DisplayNo = reader["DisplayNo"] as int?
                        });
                    }
                }
            }
        }

        // 3️⃣ GROUPING (en önemli kısım)
        foreach (var header in headers)
        {
            header.Details = details
                .Where(x => x.ReturnId == header.Id)
                .OrderBy(x => x.DisplayNo)
                .ToList();
        }

        return headers;
    }
}