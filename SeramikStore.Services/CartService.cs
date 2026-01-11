using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Data;

namespace SeramikStore.Services
{
    public class CartService : ICartService
    {
        private string connectionString = String.Empty;

        public CartService(IConfiguration config)
        { 
            connectionString = config.GetConnectionString("DefaultConnection");
        }

        public CartResultDto CartListByUserId(int userId)
        {
            var result = new CartResultDto();

            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_Cart_ListByUserId", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@UserId", userId);

            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();

            // 1️⃣ CART ITEMS
            while (reader.Read())
            {
                result.Items.Add(new CartItemDto
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    ProductId = Convert.ToInt32(reader["ProductId"]),
                    ProductCode = reader["ProductCode"].ToString(),
                    ProductName = reader["ProductName"].ToString(),
                    UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                    Quantity = Convert.ToInt32(reader["Quantity"]),
                    LineTotal = Convert.ToDecimal(reader["LineTotal"])
                });
            }

            // 2️⃣ SUMMARY
            if (reader.NextResult() && reader.Read())
            {
                result.Summary = new CartSummaryDto
                {
                    TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"])
                };
            }

            return result;
        }


        public Cart CartGetById(int cartId)
        {
            Cart cart = null;

            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_Cart_GetById", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CartId", cartId);

            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                cart = new Cart
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    ProductId = Convert.ToInt32(reader["ProductId"]),
                    ProductCode = reader["ProductCode"].ToString(),
                    ProductName = reader["ProductName"].ToString(),
                    UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                    Quantity = Convert.ToInt32(reader["Quantity"]),
                    TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                    UserId = Convert.ToInt32(reader["UserId"])
                };
            }

            return cart;
        }

        public int SaveCart(Cart cart)
        {
            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_Cart_Insert", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@ProductId", cart.ProductId);
            command.Parameters.AddWithValue("@ProductCode", cart.ProductCode);
            command.Parameters.AddWithValue("@ProductName", cart.ProductName);
            command.Parameters.AddWithValue("@UnitPrice", cart.UnitPrice);
            command.Parameters.AddWithValue("@Quantity", cart.Quantity);
            command.Parameters.AddWithValue("@UserId", cart.UserId);

            connection.Open();
            return (int)command.ExecuteScalar();
        }

        public int UpdateCart(int cartId, int quantity)
        {
            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_Cart_UpdateQuantity", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CartId", cartId);
            command.Parameters.AddWithValue("@Quantity", quantity);

            connection.Open();
            return (int)command.ExecuteScalar();
        }

        public int CartDeleteById(int cartId)
        {
            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_Cart_DeleteById", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CartId", cartId);

            connection.Open();
            return (int)command.ExecuteScalar();
        }
    }
}
