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
        public class CurrencyService : ICurrencyService
        {
        private string connectionString = String.Empty;

        public CurrencyService(IConfiguration config)
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
        // LIST
        public List<Currency> CurrencyList()
            {
                List<Currency> currencies = new List<Currency>();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand("sp_Currency_List", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            currencies.Add(new Currency
                            {
                                CurrencyId = Convert.ToInt32(reader["CurrencyId"]),
                                Code = reader["Code"].ToString(),
                                Name = reader["Name"].ToString(),
                                Symbol = reader["Symbol"].ToString(),
                                ExchangeRate = Convert.ToDecimal(reader["ExchangeRate"]),
                                IsDefault = Convert.ToBoolean(reader["IsDefault"]),
                                IsActive = Convert.ToBoolean(reader["IsActive"])
                            });
                        }
                    }
                }

                return currencies;
            }

            // GET DEFAULT
            public Currency GetDefaultCurrency()
            {
                Currency currency = null;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand("sp_Currency_GetDefault", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            currency = new Currency
                            {
                                CurrencyId = Convert.ToInt32(reader["CurrencyId"]),
                                Code = reader["Code"].ToString(),
                                Name = reader["Name"].ToString(),
                                Symbol = reader["Symbol"].ToString(),
                                ExchangeRate = Convert.ToDecimal(reader["ExchangeRate"]),
                                IsDefault = Convert.ToBoolean(reader["IsDefault"]),
                                IsActive = Convert.ToBoolean(reader["IsActive"])
                            };
                        }
                    }
                }

                return currency;
            }

            // INSERT
            public void InsertCurrency(Currency currency)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand("sp_Currency_Insert", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Code", currency.Code);
                    command.Parameters.AddWithValue("@Name", currency.Name);
                    command.Parameters.AddWithValue("@Symbol", currency.Symbol);
                    command.Parameters.AddWithValue("@ExchangeRate", currency.ExchangeRate);
                    command.Parameters.AddWithValue("@IsDefault", currency.IsDefault);

                    command.ExecuteNonQuery();
                }
            }

            // UPDATE
            public void UpdateCurrency(Currency currency)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand("sp_Currency_Update", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@CurrencyId", currency.CurrencyId);
                    command.Parameters.AddWithValue("@Code", currency.Code);
                    command.Parameters.AddWithValue("@Name", currency.Name);
                    command.Parameters.AddWithValue("@Symbol", currency.Symbol);
                    command.Parameters.AddWithValue("@ExchangeRate", currency.ExchangeRate);
                    command.Parameters.AddWithValue("@IsDefault", currency.IsDefault);
                    command.Parameters.AddWithValue("@IsActive", currency.IsActive);

                    command.ExecuteNonQuery();
                }
            }

            // DELETE (Soft Delete)
            public void DeleteCurrency(int currencyId)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    SqlCommand command = new SqlCommand("sp_Currency_Delete", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@CurrencyId", currencyId);

                    command.ExecuteNonQuery();
                }
            }
        }
    }


