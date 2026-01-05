using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System.Collections.Generic;
using System.Data;

namespace SeramikStore.Services
{
    public class UserAddressService : IUserAddressService
    {
        private readonly string _connectionString;

        public UserAddressService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public List<UserAddress> GetByUserId(int userId)
        {
            List<UserAddress> list = new();

            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_UserAddress_ListByUserId", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);

            con.Open();
            using SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                list.Add(new UserAddress
                {
                    Id = (int)dr["Id"],
                    UserId = (int)dr["UserId"],
                    Ad = dr["Ad"].ToString(),
                    Soyad = dr["Soyad"].ToString(),
                    Telefon = dr["Telefon"].ToString(),
                    Il = dr["Il"].ToString(),
                    Ilce = dr["Ilce"].ToString(),
                    Mahalle = dr["Mahalle"].ToString(),
                    Adres = dr["Adres"].ToString(),
                    Baslik = dr["Baslik"].ToString(),
                    IsDefault = (bool)dr["IsDefault"]
                });
            }
            return list;
        }

        public UserAddress GetById(int id)
        {
            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_UserAddress_GetById", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);

            con.Open();
            using SqlDataReader dr = cmd.ExecuteReader();
            if (!dr.Read()) return null;

            return new UserAddress
            {
                Id = (int)dr["Id"],
                UserId = (int)dr["UserId"],
                Ad = dr["Ad"].ToString(),
                Soyad = dr["Soyad"].ToString(),
                Telefon = dr["Telefon"].ToString(),
                Il = dr["Il"].ToString(),
                Ilce = dr["Ilce"].ToString(),
                Mahalle = dr["Mahalle"].ToString(),
                Adres = dr["Adres"].ToString(),
                Baslik = dr["Baslik"].ToString(),
                IsDefault = (bool)dr["IsDefault"]
            };
        }

        public void Insert(UserAddress address)
        {
            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_UserAddress_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@UserId", address.UserId);
            cmd.Parameters.AddWithValue("@Ad", address.Ad);
            cmd.Parameters.AddWithValue("@Soyad", address.Soyad);
            cmd.Parameters.AddWithValue("@Telefon", address.Telefon);
            cmd.Parameters.AddWithValue("@Il", address.Il);
            cmd.Parameters.AddWithValue("@Ilce", address.Ilce);
            cmd.Parameters.AddWithValue("@Mahalle", address.Mahalle);
            cmd.Parameters.AddWithValue("@Adres", address.Adres);
            cmd.Parameters.AddWithValue("@Baslik", address.Baslik);
            cmd.Parameters.AddWithValue("@IsDefault", address.IsDefault);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        public void Update(UserAddress address)
        {
            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_UserAddress_Update", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Id", address.Id);
            cmd.Parameters.AddWithValue("@UserId", address.UserId);
            cmd.Parameters.AddWithValue("@Ad", address.Ad);
            cmd.Parameters.AddWithValue("@Soyad", address.Soyad);
            cmd.Parameters.AddWithValue("@Telefon", address.Telefon);
            cmd.Parameters.AddWithValue("@Il", address.Il);
            cmd.Parameters.AddWithValue("@Ilce", address.Ilce);
            cmd.Parameters.AddWithValue("@Mahalle", address.Mahalle);
            cmd.Parameters.AddWithValue("@Adres", address.Adres);
            cmd.Parameters.AddWithValue("@Baslik", address.Baslik);
            cmd.Parameters.AddWithValue("@IsDefault", address.IsDefault);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        public void Delete(int id)
        {
            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_UserAddress_Delete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);

            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
}
