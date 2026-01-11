using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
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

        public OrderCreateResultDto CreateOrder(OrderInfoDto orderInfo)
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

        public OrderInfoDto GetOrderById(int orderId)
        {
            OrderInfoDto order = null;

            using SqlConnection conn = new(_connectionString);
            using SqlCommand cmd = new("sp_Order_GetById", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@OrderId", orderId);

            conn.Open();

            using SqlDataReader reader = cmd.ExecuteReader();

            // 1️⃣ HEADER
            if (reader.Read())
            {
                order = new OrderInfoDto
                {
                    OrderId = Convert.ToInt32(reader["Id"]),
                    OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                    OrderStatus = reader["OrderStatus"].ToString(),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    PaymentType = reader["PaymentType"].ToString(),
                    UserId = Convert.ToInt32(reader["UserId"]),
                    AddressId = Convert.ToInt32(reader["AddressId"]),
                    ProductTotal = Convert.ToDecimal(reader["ProductTotal"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"])
                };
            }

            // Header yoksa detail okumaya gerek yok
            if (order == null)
                return null;

            // 2️⃣ DETAIL
            if (reader.NextResult())
            {
                while (reader.Read())
                {
                    order.Details.Add(new OrderDetailDto
                    {
                        ProductCode = reader["ProductCode"].ToString(),
                        ProductName = reader["ProductName"].ToString(),
                        ProductDesc = reader["ProductDesc"].ToString(),
                        UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                        Quantity = Convert.ToInt32(reader["Quantity"]),
                        LineTotal = Convert.ToDecimal(reader["LineTotal"]),
                        DisplayNo = Convert.ToInt32(reader["DisplayNo"])
                    });
                }
            }

            return order;
        }
        public List<OrderListItemDto> GetOrdersByUserId(int userId)
        {
            List<OrderListItemDto> list = new();

            using SqlConnection conn = new(_connectionString);
            using SqlCommand cmd = new("sp_Order_ListByUserId", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);

            conn.Open();
            using SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new OrderListItemDto
                {
                    OrderId = Convert.ToInt32(reader["Id"]),
                    OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                    OrderStatus = reader["OrderStatus"].ToString(),
                    PaymentType = reader["PaymentType"].ToString(),
                    ProductTotal = Convert.ToDecimal(reader["ProductTotal"]),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"])
                });
            }

            return list;
        }

    }
}