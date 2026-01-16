using System;
using System.Data;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using SeramikStore.Contracts.Kasa;
using SeramikStore.Contracts.Common;

namespace SeramikStore.Repositories
{
    public interface IKasaRepository
    {
        int Insert(KasaCreateDto dto);
        void Update(KasaUpdateDto dto);
        void Delete(int id);
        void DeleteSoft(int id);
        KasaDto? GetById(int id);
        List<KasaListItemDto> List();
        PagedResult<KasaListItemDto> PagedList(int page, int pageSize);
    }


    public class KasaRepository : IKasaRepository
    {
        private readonly string _connectionString;

        public KasaRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public int Insert(KasaCreateDto dto)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_Insert", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductId", dto.ProductId);
            cmd.Parameters.AddWithValue("@ProductCode", dto.ProductCode);
            cmd.Parameters.AddWithValue("@ProductName", dto.ProductName);
            cmd.Parameters.AddWithValue("@UnitPrice", dto.UnitPrice);
            cmd.Parameters.AddWithValue("@Quantity", dto.Quantity);
            cmd.Parameters.AddWithValue("@TotalAmount", dto.TotalAmount);
            cmd.Parameters.AddWithValue("@UserId", dto.UserId);
            conn.Open();
            return Convert.ToInt32(cmd.ExecuteScalar());
        }


        public void Update(KasaUpdateDto dto)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_Update", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", dto.Id);
            cmd.Parameters.AddWithValue("@ProductId", dto.ProductId);
            cmd.Parameters.AddWithValue("@ProductCode", dto.ProductCode);
            cmd.Parameters.AddWithValue("@ProductName", dto.ProductName);
            cmd.Parameters.AddWithValue("@UnitPrice", dto.UnitPrice);
            cmd.Parameters.AddWithValue("@Quantity", dto.Quantity);
            cmd.Parameters.AddWithValue("@TotalAmount", dto.TotalAmount);
            cmd.Parameters.AddWithValue("@UserId", dto.UserId);
            cmd.Parameters.AddWithValue("@UpdateDate", dto.UpdateDate);
            cmd.Parameters.AddWithValue("@IsActive", dto.IsActive);
            conn.Open();
            cmd.ExecuteNonQuery();
        }


        public void Delete(int id)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_Delete", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }

        public void DeleteSoft(int id)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_DeleteSoft", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }

        public KasaDto? GetById(int id)
        {
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_GetById", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Id", id);
            conn.Open();
            using var rdr = cmd.ExecuteReader();
            if (!rdr.Read()) return null;

            return new KasaDto
            {
                Id = (int)rdr["Id"],
                ProductId = (int)rdr["ProductId"],
                ProductCode = (string)rdr["ProductCode"],
                ProductName = (string)rdr["ProductName"],
                UnitPrice = (decimal)rdr["UnitPrice"],
                Quantity = (int)rdr["Quantity"],
                TotalAmount = (decimal)rdr["TotalAmount"],
                UserId = (int)rdr["UserId"],
                InsertDate = (DateTime)rdr["InsertDate"],
                UpdateDate = (DateTime)rdr["UpdateDate"],
                IsActive = (bool)rdr["IsActive"],
            };
        }


        public List<KasaListItemDto> List()
        {
            var list = new List<KasaListItemDto>();
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_List", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                list.Add(new KasaListItemDto
                {
                    Id = (int)rdr["Id"],
                    ProductId = (int)rdr["ProductId"],
                    ProductCode = (string)rdr["ProductCode"],
                    ProductName = (string)rdr["ProductName"],
                    UnitPrice = (decimal)rdr["UnitPrice"],
                    Quantity = (int)rdr["Quantity"],
                    TotalAmount = (decimal)rdr["TotalAmount"],
                    UserId = (int)rdr["UserId"],
                    InsertDate = (DateTime)rdr["InsertDate"],
                    IsActive = (bool)rdr["IsActive"],
                });
            }
            return list;
        }


        public PagedResult<KasaListItemDto> PagedList(int page, int pageSize)
        {
            var result = new PagedResult<KasaListItemDto>();
            using var conn = new SqlConnection(_connectionString);
            using var cmd = new SqlCommand("sp_Kasa_PagedList", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Page", page);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            conn.Open();
            using var rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                result.Items.Add(new KasaListItemDto
                {
                    Id = (int)rdr["Id"],
                    ProductId = (int)rdr["ProductId"],
                    ProductCode = (string)rdr["ProductCode"],
                    ProductName = (string)rdr["ProductName"],
                    UnitPrice = (decimal)rdr["UnitPrice"],
                    Quantity = (int)rdr["Quantity"],
                    TotalAmount = (decimal)rdr["TotalAmount"],
                    UserId = (int)rdr["UserId"],
                    InsertDate = (DateTime)rdr["InsertDate"],
                    IsActive = (bool)rdr["IsActive"],
                });
            }

            if (rdr.NextResult() && rdr.Read())
                result.TotalCount = (int)rdr["TotalCount"];

            return result;
        }

    }

}
