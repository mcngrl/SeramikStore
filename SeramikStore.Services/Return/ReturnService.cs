using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
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

    public List<ReturnHeaderDto> GetReturnsByOrderId(int orderId, int userId)
    {
        var headers = new List<ReturnHeaderDto>();
        var details = new List<ReturnDetailDto>();

        using (var conn = new SqlConnection(_connectionString))
        using (var cmd = new SqlCommand("sp_Return_GetByOrderId", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@UserId", userId);

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

    public List<ReturnCreateItemDto> GetOrderForNewReturn(int orderId, int userId)
    {
        var list = new List<ReturnCreateItemDto>();

        using (var conn = new SqlConnection(_connectionString))
        using (var cmd = new SqlCommand("sp_Order_GetForNewReturn", conn))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@UserId", userId);

            conn.Open();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    list.Add(new ReturnCreateItemDto
                    {
                        OrderId = (int)reader["OrderId"],
                        OrderDetailId = (int)reader["OrderDetailId"],
                        ProductId = (int)reader["ProductId"],

                        ProductCode = reader["ProductCode"]?.ToString(),
                        ProductName = reader["ProductName"]?.ToString(),
                        ProductDesc = reader["ProductDesc"]?.ToString(),
                        UnitPrice = (decimal)reader["UnitPrice"],
                        Quantity = (int)reader["Quantity"],
                        LineTotal = (decimal)reader["LineTotal"],
                        DisplayNo = (int)reader["DisplayNo"],
                        ImagePath = reader["ImagePath"]?.ToString(),

                        LineReturnQuantityTotal = (int)reader["LineReturnQuantityTotal"],
                        LineReturnPriceTotal = (decimal)reader["LineReturnPriceTotal"],
                        AvaliableQuatityForReturn = (int)reader["AvaliableQuatityForReturn"],
                        CurrencyCode = reader["CurrencyCode"]?.ToString()
                    });
                }
            }
        }

        return list;
    }

    public (int Result, string Message) CreateReturn(ReturnCreateDto model)
    {
        using var conn = new SqlConnection(_connectionString);
        using var cmd = new SqlCommand("sp_Return_Create", conn);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@OrderId", model.OrderId);
        cmd.Parameters.AddWithValue("@UserId", model.UserId);
        cmd.Parameters.AddWithValue("@Reason", model.Reason ?? (object)DBNull.Value);

        // JSON serialize
        var jsonItems = JsonConvert.SerializeObject(
            model.Items.Select(x => new
            {
                x.OrderDetailId,
                x.ReturnQuantity
            })
        );

        cmd.Parameters.AddWithValue("@Items", jsonItems);

        conn.Open();

        using var reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            int result = reader.GetInt32(reader.GetOrdinal("Result"));
            string message = reader["Message"]?.ToString();

            return (result, message);
        }

        return (-99, "Bilinmeyen hata");
    }

}