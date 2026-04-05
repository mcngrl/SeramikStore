using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using SeramikStore.Contracts.Order;
using SeramikStore.Contracts.Reason;
using SeramikStore.Contracts.Return;
using SeramikStore.Entities;
using SeramikStore.Entities.Enums;
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

                    ReturnHeaderDto r = new ReturnHeaderDto
                    {
                        Id = reader.GetInt32(reader.GetOrdinal("Id")),
                        UserId = reader.GetInt32(reader.GetOrdinal("UserId")),
                        ReturnRequestDate = reader.GetDateTime(reader.GetOrdinal("ReturnRequestDate")),
                        OrderId = reader.GetInt32(reader.GetOrdinal("OrderId")),
                        StatusForReturnCode = reader.GetInt32(reader.GetOrdinal("StatusForReturnCode")),
                        StatusForReturnDesc = reader["StatusForReturnDesc"]?.ToString()
                    };

                    r.ReturnReason = new ReasonDto
                    {
                        Id = reader.GetInt32(reader.GetOrdinal("ReasonId")),
                        Reasondesc = reader["Reasondesc"]?.ToString()
                    };

                    r.ManuelDescriptionForReason = reader["ManuelDescriptionForReason"]?.ToString();
                    headers.Add(r);                       
                       
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
                            ReturnLineTotal = reader.GetDecimal(reader.GetOrdinal("ReturnLineTotal")),

                            OrderId = reader["OrderId"] as int?,
                            ProductCode = reader["ProductCode"]?.ToString(),
                            ProductName = reader["ProductName"]?.ToString(),
                            ProductDesc = reader["ProductDesc"]?.ToString(),
                            OrderUnitPrice = reader["OrderUnitPrice"] as decimal?,
                            Quantity = reader["Quantity"] as int?,
                            LineTotal = reader["LineTotal"] as decimal?,
                            DisplayNo = reader["DisplayNo"] as int?,
                            ImagePath = reader["ImagePath"]?.ToString(),
                            CurrencyCode = reader["CurrencyCode"]?.ToString()
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

    public (List<ReturnCreateItemDto> OrderItems, OrderStatusCode theOrderStatusCode) GetOrderForNewReturn(int orderId, int userId)
    {
        List<ReturnCreateItemDto> list = new List<ReturnCreateItemDto>();
        OrderStatusCode theresultOrderStatusCode = OrderStatusCode.NotAssigned ;

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

                if (reader.NextResult())
                {
                    if (reader.Read())
                    {
                        theresultOrderStatusCode  = (OrderStatusCode)reader.GetInt32(reader.GetOrdinal("OrderStatusCode"));

                    }
                }
            }

            

        }

        return (list, theresultOrderStatusCode);
    }



    public (int Result, string Message) CreateReturn(ReturnCreateDto model)
    {
        using var conn = new SqlConnection(_connectionString);
        using var cmd = new SqlCommand("sp_Return_Create", conn);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@OrderId", model.OrderId);
        cmd.Parameters.AddWithValue("@UserId", model.UserId);
        cmd.Parameters.AddWithValue("@ReasonId", model.ReturnReason.Id);
        cmd.Parameters.AddWithValue("@ReasonDesc", model.ReturnReason.Reasondesc);

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

    public (int Result, string Message) CancelReturn(int returnHeaderId, int userId)
    {
        using var conn = new SqlConnection(_connectionString);
        using var cmd = new SqlCommand("sp_Return_Cancel", conn);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@ReturnHeaderId", returnHeaderId);
        cmd.Parameters.AddWithValue("@UserId", userId);

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