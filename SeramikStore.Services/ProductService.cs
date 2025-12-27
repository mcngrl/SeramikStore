using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System;
using System.Collections.Generic;
using System.Data;

namespace SeramikStore.Services
{
    public class ProductService : IProductService
    {
        private string connectionString = String.Empty;

        public ProductService(IConfiguration config)
        {
            connectionString = config.GetConnectionString("DefaultConnection");
        }

        public List<Product> ProductList()
        {
            List<Product> products = new();

            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_ProductList", connection);

            command.CommandType = CommandType.StoredProcedure;
            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                products.Add(new Product
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    ProductCode = reader["ProductCode"].ToString(),
                    ProductName = reader["ProductName"].ToString(),
                    ProductDesc = reader["ProductDesc"].ToString(),
                    CategoryId = Convert.ToInt32(reader["CategoryId"]),
                    UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                    Currency = reader["Currency"].ToString(),
                    AvailableForSale = Convert.ToBoolean(reader["AvailableForSale"])
                });
            }

            return products;
        }

        public Product ProductGetById(int id)
        {
            Product product = null;

            using SqlConnection connection = new(connectionString);
            using SqlCommand command = new("sp_ProductGetById", connection);

            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Id", id);

            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                product = new Product
                {
                    Id = Convert.ToInt32(reader["Id"]),
                    ProductCode = reader["ProductCode"].ToString(),
                    ProductName = reader["ProductName"].ToString(),
                    ProductDesc = reader["ProductDesc"].ToString(),
                    CategoryId = Convert.ToInt32(reader["CategoryId"]),
                    UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                    Currency = reader["Currency"].ToString(),
                    AvailableForSale = Convert.ToBoolean(reader["AvailableForSale"])
                };
            }

            return product;
        }
    }
}
