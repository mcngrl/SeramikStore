using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{

    public class ProductServices : IProductServices
    {
        private string connectionString = String.Empty;
        public ProductServices(IConfiguration config)
        {
            // Connection string'leri config üzerinden al
            var connectionHome = config.GetConnectionString("DefaultConnectionHome");
            var connectionWork = config.GetConnectionString("DefaultConnectionWork");

            // Çalışan dizini
            var currentPath = AppDomain.CurrentDomain.BaseDirectory;

            // Ortam tespiti (UserName veya path kontrolü)
            bool isWorkEnvironment = currentPath.Contains("cgurel", StringComparison.OrdinalIgnoreCase);

            // Ortama göre connection string seçimi
            connectionString = isWorkEnvironment ? connectionWork : connectionHome;
        }
        public List<Product> ProductList()
        {
            List<Product> products = new List<Product>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand("sp_ProductList", connection);
                command.CommandType = CommandType.StoredProcedure; // Komut türünü Stored Procedure olarak ayarlıyoruz.

                using (SqlDataReader reader = command.ExecuteReader())
                {
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
                }
                connection.Close();
            }
            return products;
        }

        public List<Cart> CartListByUserId(int userId)
        {
            List<Cart> carts = new List<Cart>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Saklı yordamı çağırıyoruz
                SqlCommand command = new SqlCommand("sp_CartListByUserId", connection);
                command.CommandType = CommandType.StoredProcedure;

                // Parametreyi ekliyoruz
                command.Parameters.AddWithValue("@UserId", userId);

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        carts.Add(new Cart
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            ProductId = Convert.ToInt32(reader["ProductId"]),
                            ProductCode = reader["ProductCode"].ToString(),
                            ProductName = reader["ProductName"].ToString(),
                            UnitPrice = Convert.ToDecimal(reader["UnitPrice"]),
                            Quantity = Convert.ToInt32(reader["Quantity"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            UserId = Convert.ToInt32(reader["UserId"])
                        });
                    }
                }

                connection.Close();
            }

            return carts;
        }

        public int UpdateCart(int cartId, decimal totalAmount, int quantity)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("UpdateCart", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@CartId", cartId);
                command.Parameters.AddWithValue("@TotalAmount", totalAmount);
                command.Parameters.AddWithValue("@Quantity", quantity);

                int result = (int)command.ExecuteScalar(); // Güncellenen satır sayısını al
                return result;
            }
        }


        public Cart CartGetById(int cartId)
        {
            Cart cart = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("sp_CartGetById", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@CartId", cartId);

                using (SqlDataReader reader = command.ExecuteReader())
                {
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
                }
            }

            return cart;
        }

        public int CartDeleteById(int cartId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("sp_CartDeleteById", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@CartId", cartId);

                int result = (int)command.ExecuteScalar(); // Silinen satır sayısını al
                return result;
            }
        }

        public Product ProductGetById(int id)
        {
            Product product = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_ProductGetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Id", id);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
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
                    }
                }

                connection.Close();
            }

            return product;
        }

        public int SaveCart(Cart cart)
        {
            int CartId = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_CartInsert", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@ProductId", cart.ProductId);
                    command.Parameters.AddWithValue("@ProductCode", cart.ProductCode);
                    command.Parameters.AddWithValue("@ProductName", cart.ProductName);
                    command.Parameters.AddWithValue("@UnitPrice", cart.UnitPrice);
                    command.Parameters.AddWithValue("@Quantity", cart.Quantity);
                    command.Parameters.AddWithValue("@UserId", cart.UserId);

                    CartId = (int)command.ExecuteScalar();
                
                }

                connection.Close();
            }

            return CartId;
        }
    }
}
