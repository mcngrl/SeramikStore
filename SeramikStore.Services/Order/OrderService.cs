using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Contracts.Order;
using SeramikStore.Entities.Enums;
using System.Data;
using System.Reflection.Metadata.Ecma335;


namespace SeramikStore.Services
{


    public class OrderService : IOrderService
    {
        private string _connectionString;

        public OrderService(IConfiguration config)
        {
            _connectionString = config.GetConnectionString("DefaultConnection");
        }

        public OrderCreateResultDto CreateOrder(OrderCreateDto orderInfo)
        {
            using SqlConnection conn = new(_connectionString);
            using SqlCommand cmd = new("sp_Order_Create", conn);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", orderInfo.UserId);
            cmd.Parameters.AddWithValue("@AddressId", orderInfo.AddressId);
            cmd.Parameters.AddWithValue("@CargoAmount", orderInfo.CargoAmount);

            conn.Open();

            using SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                return new OrderCreateResultDto
                {
                    OrderId = Convert.ToInt32(reader["OrderId"]),
                    Message = reader["Message"].ToString()
                };
            }

            throw new Exception("Sipariş oluşturulamadı.");
        }

        public OrderDetailedDto GetDetailedOrderById(int orderId)
        {
            OrderDetailedDto order = null;

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand("sp_Order_GetDetailedInfoById", connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@OrderId", orderId);

                connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    // 1️⃣ HEADER
                    if (reader.Read())
                    {
                        order = new OrderDetailedDto
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                            OrderStatusCode = reader.GetInt32(reader.GetOrdinal("OrderStatusCode")),
                            OrderStatus = reader["OrderStatus"]?.ToString(),
                            CargoAmount = reader.GetDecimal(reader.GetOrdinal("CargoAmount")),
                            UserId = reader.GetInt32(reader.GetOrdinal("UserId")),
                            CurrencyCode = reader["CurrencyCode"]?.ToString(),
                            ProductTotal = reader.GetDecimal(reader.GetOrdinal("ProductTotal")),
                            GrandTotal = reader.GetDecimal(reader.GetOrdinal("GrandTotal")),
                            KargoSirketi = reader["KargoSirketi"]?.ToString(),
                            KargoyaVerilmeTarihi = reader["KargoyaVerilmeTarihi"] as DateTime?,
                            KargoTakipNo = reader["KargoTakipNo"]?.ToString(),
                            Items = new List<OrderDetailItemDto>(),
                        };
                    }

                    if (order == null)
                        return null;

                    // 2️⃣ DETAIL LIST
                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            order.Items.Add(new OrderDetailItemDto
                            {
                                ProductCode = reader["ProductCode"]?.ToString(),
                                ProductName = reader["ProductName"]?.ToString(),
                                ProductDesc = reader["ProductDesc"]?.ToString(),
                                UnitPrice = reader.GetDecimal(reader.GetOrdinal("UnitPrice")),
                                Quantity = reader.GetInt32(reader.GetOrdinal("Quantity")),
                                LineTotal = reader.GetDecimal(reader.GetOrdinal("LineTotal")),
                                DisplayNo = reader.GetInt32(reader.GetOrdinal("DisplayNo")),
                                ImagePath = reader["ImagePath"]?.ToString()
                            });
                        }
                    }

                    // 3️⃣ ADDRESS
                    if (reader.NextResult())
                    {
                        if (reader.Read())
                        {
                            order.Address = new OrderAddressDto
                            {
                                Ad = reader["Ad"]?.ToString(),
                                Soyad = reader["Soyad"]?.ToString(),
                                Telefon = reader["Telefon"]?.ToString(),
                                Mahalle = reader["Mahalle"]?.ToString(),
                                Adres = reader["Adres"]?.ToString(),
                                Ilce = reader["Ilce"]?.ToString(),
                                Il = reader["Il"]?.ToString()
                            };
                        }
                    }

                    //STATUS PROCESS
                    order.StatusProcess = GetStatusProcess(orderId);
                    //STATUS HISTORY
                    order.StatusHistory = GetStatusHistory(orderId);
                    //NEXT STATUSF
                    order.NextStatusesForUpdate = GetNextStatusesForUpdate(orderId);

                    order.ThisOrderCanBeCanceledByCustomer = OrderCanCancelbyCustomer((OrderStatusCode)order.OrderStatusCode);

                }
            }

            return order;
        }
        public List<OrderHeaderItemDto> GetOrdersByUserId(int userId)
        {
            List<OrderHeaderItemDto> list = new();

            using SqlConnection conn = new(_connectionString);
            using SqlCommand cmd = new("sp_Order_ListByUserId", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);

            conn.Open();
            using SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new OrderHeaderItemDto
                {
                    OrderId = reader.GetInt32(reader.GetOrdinal("Id")),
                    OrderDate = reader.GetDateTime(reader.GetOrdinal("OrderDate")),
                    OrderStatusCode = reader.GetInt32(reader.GetOrdinal("OrderStatusCode")),
                    OrderStatus = reader["OrderStatus"] == DBNull.Value ? "" : reader["OrderStatus"].ToString(),
                    ProductTotal = reader.GetDecimal(reader.GetOrdinal("ProductTotal")),
                    CargoAmount = reader.GetDecimal(reader.GetOrdinal("CargoAmount")),
                    GrandTotal = reader.GetDecimal(reader.GetOrdinal("GrandTotal")),
                    CurrencyCode = reader["CurrencyCode"]?.ToString(),

                });
            }

            return list;
        }

        public List<OrderAdminListItemDto> GetAllOrders()
        {
            List<OrderAdminListItemDto> list = new();

            using SqlConnection conn = new(_connectionString);
            using SqlCommand cmd = new("sp_Order_ListAll", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();

            using SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new OrderAdminListItemDto
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                    ProductTotal = Convert.ToDecimal(reader["ProductTotal"]),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"]),
                    CurrencyCode = reader["CurrencyCode"]?.ToString(),
                    OrderStatusCode = Convert.ToInt32(reader["OrderStatusCode"]),
                    OrderStatus = reader["OrderStatus"]?.ToString(),

                    UserId = Convert.ToInt32(reader["UserId"]),
                    FirstName = reader["FirstName"]?.ToString(),
                    LastName = reader["LastName"]?.ToString(),
                    Email = reader["Email"]?.ToString()
                });
            }

            return list;
        }

        public List<StatusOptionDto> GetNextStatusesForUpdate(int orderId)
        {
            var list = new List<StatusOptionDto>();

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_Order_GetNextStatusForUpdate", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderId", orderId);

                conn.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new StatusOptionDto
                        {
                            OrderStatusCode = Convert.ToInt32(reader["Code"]),
                            Aciklama = reader["Aciklama"].ToString()!
                        });
                    }
                }
            }

            return list;
        }


        public List<OrderStatusHistoryDto> GetStatusHistory(int orderId)
        {
            var list = new List<OrderStatusHistoryDto>();

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_Order_GetStatusHistory", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                conn.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new OrderStatusHistoryDto
                        {
                            OrderStatusCode = reader.GetInt32(reader.GetOrdinal("OrderStatusCode")),
                            IslemTarihi = reader.GetDateTime(reader.GetOrdinal("IslemTarihi")),
                            Aciklama = reader["Aciklama"]?.ToString(),
                            UserNameSurname = reader["UserNameSurname"]?.ToString()
                        });
                    }
                }
            }

            return list;
        }

        public List<OrderStatusProcessDto> GetStatusProcess(int orderId)
        {
            var list = new List<OrderStatusProcessDto>();

            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_Order_GetStatusProcess", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                conn.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new OrderStatusProcessDto
                        {
                            RowOrderNo = reader.GetInt32(reader.GetOrdinal("RowOrderNo")),
                            Faz = reader["Faz"]?.ToString(),
                            OrderStatusCode = reader.GetInt32(reader.GetOrdinal("Code")),
                            IslemTarihi = reader.GetDateTime(reader.GetOrdinal("IslemTarihi")),
                            Aciklama = reader["Aciklama"]?.ToString(),
                            UserNameSurname = reader["UserNameSurname"]?.ToString(),
                            isLast = reader.GetBoolean(reader.GetOrdinal("IsLast")),
                            isCompleted = reader.GetBoolean(reader.GetOrdinal("IsCompleted")),
                            
                        });
                    }
                }
            }

            return list;
        }



        public OrderStatusUpdateResultDto UpdateOrderStatus(int orderId, int newStatusCode, int userId)
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_Order_UpdateStatus", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                cmd.Parameters.AddWithValue("@NewStatusCode", newStatusCode);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                using SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    return new OrderStatusUpdateResultDto
                    {
                        Result = Convert.ToInt32(reader["RESULT"]),
                    };
                }
                else
                {
                    return new OrderStatusUpdateResultDto
                    {
                        Result = 0
                    };
                }

           }
        }

        public void CancelLastStatus(CancelLastStatusRequestDto request)
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand("sp_Order_CancelLastStatus", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@OrderId", request.OrderId);
                cmd.Parameters.AddWithValue("@UserId", request.UserId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public bool OrderCanCancelbyCustomer(OrderStatusCode status)
        {
            return status == OrderStatusCode.OrderCreated
                || status == OrderStatusCode.PaymentPending;
        }

  
    }
}


