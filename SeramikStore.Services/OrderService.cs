using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Data;

namespace SeramikStore.Services
{
    using Microsoft.Data.SqlClient;
    using System.Data;

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
                            StatusHistory = new List<OrderStatusHistoryDto>()
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

                    // 4️⃣ STATUS HISTORY
                    if (reader.NextResult())
                    {
                        while (reader.Read())
                        {
                            order.StatusHistory.Add(new OrderStatusHistoryDto
                            {
                                StatusCode = reader["StatusCode"]?.ToString(),
                                IslemTarihi = reader.GetDateTime(reader.GetOrdinal("IslemTarihi")),
                                Aciklama = reader["Aciklama"]?.ToString()
                            });
                        }
                    }
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
                    OrderStatus = reader["OrderStatus"] == DBNull.Value ? "" : reader["OrderStatus"].ToString(),
                    ProductTotal = reader.GetDecimal(reader.GetOrdinal("ProductTotal")),
                    CargoAmount = reader.GetDecimal(reader.GetOrdinal("CargoAmount")),
                    GrandTotal = reader.GetDecimal(reader.GetOrdinal("GrandTotal")),
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
                    OrderStatus = reader["OrderStatus"]?.ToString(),

                    UserId = Convert.ToInt32(reader["UserId"]),
                    FirstName = reader["FirstName"]?.ToString(),
                    LastName = reader["LastName"]?.ToString(),
                    Email = reader["Email"]?.ToString()
                });
            }

            return list;
        }


    }
}


