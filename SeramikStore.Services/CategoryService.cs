using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System.Data;

public class CategoryService : ICategoryService
{
    private readonly string _connectionString;

    public CategoryService(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("DefaultConnection");
    }

    // 🔹 LIST
    public List<Category> CategoryList()
    {
        var list = new List<Category>();

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Category_List", con);

        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();

        using SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            list.Add(new Category
            {
                Id = Convert.ToInt32(dr["Id"]),
                Name = dr["Name"].ToString(),
                IsActive = Convert.ToBoolean(dr["IsActive"])
            });
        }

        return list;
    }

    // 🔹 GET BY ID
    public Category CategoryGetById(int id)
    {
        Category category = null;

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Category_GetById", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            category = new Category
            {
                Id = Convert.ToInt32(dr["Id"]),
                Name = dr["Name"].ToString(),
                IsActive = Convert.ToBoolean(dr["IsActive"])
            };
        }

        return category;
    }

    // 🔹 INSERT
    public int InsertCategory(Category category)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Category_Insert", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Name", category.Name);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    // 🔹 UPDATE
    public int UpdateCategory(Category category)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Category_Update", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", category.Id);
        cmd.Parameters.AddWithValue("@Name", category.Name);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    // 🔹 DELETE
    public int DeleteCategory(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_Category_Delete", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }
}
