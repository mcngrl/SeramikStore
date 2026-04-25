using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using SeramikStore.Contracts.Order;
using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using System.Reflection.PortableExecutable;

public class ProductService : IProductService
{
    private string _connectionString = String.Empty;

    public ProductService(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("DefaultConnection");
    }

    public List<ProductListForHomeDto> ProductList(int CategoryId)
    {
        List<ProductListForHomeDto> list = new();

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_ListForHomePage", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryId", CategoryId);
        con.Open();

        using SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            list.Add(new ProductListForHomeDto
            {
                Id = Convert.ToInt32(dr["Id"]),
                ProductCode = dr["ProductCode"].ToString(),
                ProductName = dr["ProductName"].ToString(),
                ProductDesc = dr["ProductDesc"].ToString(),
                UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                CurrencyId = Convert.ToInt32(dr["CurrencyId"]),
                StockAmount = Convert.ToInt32(dr["StockAmount"]),
                AvailableForSale = Convert.ToBoolean(dr["AvailableForSale"]),
                CurrencyCode = dr["CurrencyCode"].ToString(),
                CurrencySymbol = dr["CurrencySymbol"].ToString(),
                MainImagePath = dr["MainImagePath"].ToString()
            });
        }

        return list;
    }


    public List<ProductListForAdminDto> ProductListForAdmin() {

        List<ProductListForAdminDto> list = new();

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_List", con);

        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();

        using SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            list.Add(new ProductListForAdminDto
            {
                Id = Convert.ToInt32(dr["Id"]),
                ProductCode = dr["ProductCode"].ToString(),
                ProductName = dr["ProductName"].ToString(),
                ProductDesc = dr["ProductDesc"].ToString(),
                UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                AvailableForSale = Convert.ToBoolean(dr["AvailableForSale"]),
                CurrencyCode = dr["CurrencyCode"].ToString(),
                CurrencySymbol = dr["CurrencySymbol"].ToString(),
                MainImagePath = dr["MainImagePath"].ToString(),
                ImageCount = Convert.ToInt32(dr["ImageCount"]),
                StockAmount = Convert.ToInt32(dr["StockAmount"])
            });
        }

        return list;
    }
    public ProductDetailDto ProductGetById(int id)
    {
        ProductDetailDto product = null;

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_InfoById", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();

        using SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            product = new ProductDetailDto
            {
                Id = Convert.ToInt32(dr["Id"]),
                ProductCode = dr["ProductCode"].ToString(),
                ProductName = dr["ProductName"].ToString(),
                ProductDesc = dr["ProductDesc"].ToString(),
                UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                CurrencyId = Convert.ToInt32(dr["CurrencyId"]),
                StockAmount = Convert.ToInt32(dr["StockAmount"]),
                AvailableForSale = Convert.ToBoolean(dr["AvailableForSale"]),
                CurrencyCode = dr["CurrencyCode"].ToString(),
                CurrencySymbol = dr["CurrencySymbol"].ToString()
            };
        }

        if (product.SelectedCategoryIds == null)
            product.SelectedCategoryIds = new List<int>();

        if (dr.NextResult())
        {
            while (dr.Read())
            {
 
                if (dr["CategoryId"] != DBNull.Value)
                {
                    product.SelectedCategoryIds.Add(Convert.ToInt32(dr["CategoryId"]));
                }
            }
        }

        return product;
    }

    public int InsertProduct(Product product)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_Insert", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductCode", product.ProductCode);
        cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
        cmd.Parameters.AddWithValue("@ProductDesc", product.ProductDesc);
        cmd.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
        cmd.Parameters.AddWithValue("@CurrencyId", product.CurrencyId);
        cmd.Parameters.AddWithValue("@AvailableForSale", product.AvailableForSale);
        cmd.Parameters.AddWithValue("@StockAmount", product.StockAmount);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public int UpdateProduct(Product product)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_Update", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", product.Id);
        cmd.Parameters.AddWithValue("@ProductCode", product.ProductCode);
        cmd.Parameters.AddWithValue("@ProductName", product.ProductName);
        cmd.Parameters.AddWithValue("@ProductDesc", product.ProductDesc);
        cmd.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
        cmd.Parameters.AddWithValue("@CurrencyId", product.CurrencyId);
        cmd.Parameters.AddWithValue("@AvailableForSale", product.AvailableForSale);
        cmd.Parameters.AddWithValue("@StockAmount", product.StockAmount);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public int DeleteProduct(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_Delete", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public void UpdateDisplayOrder(List<ProductOrderDto> list)
    {
        try
        {
            var json = JsonConvert.SerializeObject(list);

            using SqlConnection con = new(_connectionString);
            using SqlCommand cmd = new("sp_Product_UpdateDisplayOrder", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@JsonData", json);

            con.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {

            string msg = e.Message;
        }

    }

    public void SaveProductCategories(int productId, List<int> categoryIds)
    {
        var json = JsonConvert.SerializeObject(categoryIds);

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_SaveCategories", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductId", productId);
        cmd.Parameters.AddWithValue("@CategoryJson", json);

        con.Open();
        cmd.ExecuteNonQuery();

    }
}
