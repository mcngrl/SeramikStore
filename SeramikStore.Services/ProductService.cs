using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System.Collections.Generic;
using System.Data;

public class ProductService : IProductService
{
    private string _connectionString = String.Empty;

    public ProductService(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("DefaultConnection");
    }

    public List<ProductListForHomeDto> ProductList()
    {
        List<ProductListForHomeDto> list = new();

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_ListForHomePage", con);

        cmd.CommandType = CommandType.StoredProcedure;
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
                CategoryName = dr["CategoryName"].ToString(),
                CategoryId = Convert.ToInt32(dr["CategoryId"]),
                UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                CurrencyId = Convert.ToInt32(dr["CurrencyId"]),
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
                CategoryName = dr["CategoryName"].ToString(),
            });
        }

        return list;
    }
    public Product ProductGetById(int id)
    {
        Product product = null;

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Product_GetById", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();

        using SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            product = new Product
            {
                Id = Convert.ToInt32(dr["Id"]),
                ProductCode = dr["ProductCode"].ToString(),
                ProductName = dr["ProductName"].ToString(),
                ProductDesc = dr["ProductDesc"].ToString(),
                CategoryId = Convert.ToInt32(dr["CategoryId"]),
                UnitPrice = Convert.ToDecimal(dr["UnitPrice"]),
                CurrencyId = Convert.ToInt32(dr["CurrencyId"]),
                AvailableForSale = Convert.ToBoolean(dr["AvailableForSale"])
            };
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
        cmd.Parameters.AddWithValue("@CategoryId", product.CategoryId);
        cmd.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
        cmd.Parameters.AddWithValue("@CurrencyId", product.CurrencyId);
        cmd.Parameters.AddWithValue("@AvailableForSale", product.AvailableForSale);

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
        cmd.Parameters.AddWithValue("@CategoryId", product.CategoryId);
        cmd.Parameters.AddWithValue("@UnitPrice", product.UnitPrice);
        cmd.Parameters.AddWithValue("@CurrencyId", product.CurrencyId);
        cmd.Parameters.AddWithValue("@AvailableForSale", product.AvailableForSale);

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
}
