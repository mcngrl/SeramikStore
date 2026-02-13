using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Contracts.Cart;
using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Data;

namespace SeramikStore.Services
{
    public partial class CartService : ICartService
    {
  
        public CartResultDto CartListByUserId(int userId)
        {
            var result = new CartResultDto();
  
            using SqlConnection connection = new(_connectionString);
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
                    LineTotal = Convert.ToDecimal(reader["LineTotal"]),
                    CurrencyCode = reader["CurrencyCode"].ToString(),
                    MainImagePath = reader["MainImagePath"].ToString(),

                });
            }

            // 2️⃣ SUMMARY
            if (reader.NextResult() && reader.Read())
            {
                result.Summary = new CartSummaryDto
                {
                    TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"]),
                    CurrencyCode = reader["CurrencyCode"].ToString()
                };
            }

            return result;
        }


        public Cart CartGetById(int cartId)
        {
            Cart cart = null;

            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("sp_Cart_GetById", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Id", cartId);

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
                    UserId = reader["UserId"] == DBNull.Value ? (int?)null : (int)reader["UserId"],
                    cart_id_token = reader["cart_id_token"] == DBNull.Value ? (string?)null : (string)reader["cart_id_token"],
                    CurrencyCode = reader["CurrencyCode"].ToString()

                };
            }

            return cart;
        }

        public int SaveCart(Cart cart)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("sp_Cart_Save", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@ProductId", cart.ProductId);
            command.Parameters.AddWithValue("@ProductCode", cart.ProductCode);
            command.Parameters.AddWithValue("@ProductName", cart.ProductName);
            command.Parameters.AddWithValue("@UnitPrice", cart.UnitPrice);
            command.Parameters.AddWithValue("@Quantity", cart.Quantity);
            command.Parameters.AddWithValue("@TotalAmount", cart.TotalAmount);
            command.Parameters.AddWithValue("@UserId", cart.UserId);
            command.Parameters.AddWithValue("@cart_id_token", cart.cart_id_token);
            command.Parameters.AddWithValue("@CurrencyCode", cart.CurrencyCode);

            connection.Open();
            return Convert.ToInt32(command.ExecuteScalar());
        }

        public int UpdateCart(int cartId, int quantity)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("sp_Cart_UpdateQuantity", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CartId", cartId);
            command.Parameters.AddWithValue("@Quantity", quantity);

            connection.Open();
            return (int)command.ExecuteScalar();
        }

        public int CartDeleteById(int cartId)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("sp_Cart_DeleteById", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CartId", cartId);

            connection.Open();
            return (int)command.ExecuteScalar();
        }

        public CartResultDto CartListByCartToken(string cart_id_token)
        {
            var result = new CartResultDto();

            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("sp_Cart_ListByCartToken", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@cart_id_token", cart_id_token);

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
                    LineTotal = Convert.ToDecimal(reader["LineTotal"]),
                    CurrencyCode = reader["CurrencyCode"].ToString(),
                    MainImagePath = reader["MainImagePath"].ToString(),

                });
            }

            // 2️⃣ SUMMARY
            if (reader.NextResult() && reader.Read())
            {
                result.Summary = new CartSummaryDto
                {
                    TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                    CargoAmount = Convert.ToDecimal(reader["CargoAmount"]),
                    GrandTotal = Convert.ToDecimal(reader["GrandTotal"]),
                    CurrencyCode = reader["CurrencyCode"].ToString(),

                };
            }

            return result;
        }


        public void MergeAnonymousCartToUser(string cartToken, int userId)
        {
            var anonItems = CartListByCartToken(cartToken).Items;

            if (!anonItems.Any())
                return;

            var userItems = CartListByUserId(userId).Items;

            foreach (var anon in anonItems)
            {
                var existing = userItems
                    .FirstOrDefault(x => x.ProductId == anon.ProductId);

                if (existing != null)
                {
                    existing.Quantity += anon.Quantity;

                    CartUpdateDto existingToUpdate = new CartUpdateDto
                    {
                        Id = existing.Id,
                        ProductId = existing.ProductId,
                        ProductCode = existing.ProductCode,
                        ProductName = existing.ProductName,
                        UnitPrice = existing.UnitPrice,
                        Quantity = existing.Quantity,
                        TotalAmount = existing.LineTotal,
                        UserId = userId,
                        CurrencyCode = existing.CurrencyCode,
                    };


                    Update(existingToUpdate);


                    Delete(anon.Id);
                }
                else
                {
                    CartUpdateDto anonToUpdate = new CartUpdateDto
                    {
                        Id = anon.Id,
                        ProductId = anon.ProductId,
                        ProductCode = anon.ProductCode,
                        ProductName = anon.ProductName,
                        UnitPrice = anon.UnitPrice,
                        Quantity = anon.Quantity,
                        TotalAmount = anon.LineTotal,
                        UserId = userId,
                        cart_id_token = null,
                        CurrencyCode = anon.CurrencyCode,
                        
                    };
                    Update(anonToUpdate);
                }
            }
        }

        public void IncreaseQuantity(int cartId)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Cart_IncreaseQuantity", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CartId", cartId);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        public void DecreaseQuantity(int cartId)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Cart_DecreaseQuantity", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CartId", cartId);

            conn.Open();
            cmd.ExecuteNonQuery();
        }


    }
}
