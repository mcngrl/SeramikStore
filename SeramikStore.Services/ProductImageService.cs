using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System.Data;

public class ProductImageService : IProductImageService
{
    private readonly string _connectionString;

    public ProductImageService(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("DefaultConnection");
    }

    public int Insert(ProductImage image)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_ProductImage_Insert", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductId", image.ProductId);
        cmd.Parameters.AddWithValue("@ImagePath", image.ImagePath);
        cmd.Parameters.AddWithValue("@IsMain", image.IsMain);
        cmd.Parameters.AddWithValue("@DisplayOrder", image.DisplayOrder);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public int Update(ProductImage image)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_ProductImage_Update", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", image.Id);
        cmd.Parameters.AddWithValue("@IsMain", image.IsMain);
        cmd.Parameters.AddWithValue("@DisplayOrder", image.DisplayOrder);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public int Delete(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_ProductImage_Delete", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public List<ProductImage> GetByProductId(int productId)
    {
        List<ProductImage> list = new();

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_ProductImage_ListByProductId", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductId", productId);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            list.Add(new ProductImage
            {
                Id = Convert.ToInt32(dr["Id"]),
                ProductId = Convert.ToInt32(dr["ProductId"]),
                ImagePath = dr["ImagePath"].ToString(),
                IsMain = Convert.ToBoolean(dr["IsMain"]),
                DisplayOrder = Convert.ToInt32(dr["DisplayOrder"])
            });
        }

        return list;
    }

    public void SetMainImage(int productId, int imageId)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_ProductImage_SetMain", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductId", productId);
        cmd.Parameters.AddWithValue("@ImageId", imageId);

        con.Open();
        cmd.ExecuteNonQuery();
    }
}
