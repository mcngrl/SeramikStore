using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System.Data;
using Microsoft.AspNetCore.Identity;
public class UserService : IUserService
{
    private readonly string _connectionString;

    private readonly PasswordHasher<User> _passwordHasher;

    public UserService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
        _passwordHasher = new PasswordHasher<User>();
    }

    public void Insert(User user, string plainPassword)
    {
        user.PasswordHash =
         _passwordHasher.HashPassword(user, plainPassword);

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_Insert", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
        cmd.Parameters.AddWithValue("@LastName", user.LastName);
        cmd.Parameters.AddWithValue("@Email", user.Email);
        cmd.Parameters.AddWithValue("@PasswordHash", user.PasswordHash);
        cmd.Parameters.AddWithValue("@PhoneNumber", user.PhoneNumber ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@BirthDate", user.BirthDate ?? (object)DBNull.Value);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public List<User> GetAll()
    {
        List<User> list = new();
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_List", con);
        cmd.CommandType = CommandType.StoredProcedure;

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            list.Add(MapUser(dr));
        }
        return list;
    }

    public User GetById(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetById", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        return dr.Read() ? MapUser(dr) : null;
    }

    public User GetByEmail(string email)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetByEmail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", email);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        return dr.Read() ? MapUser(dr) : null;
    }

    public void Update(User user)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_Update", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@Id", user.Id);
        cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
        cmd.Parameters.AddWithValue("@LastName", user.LastName);
        cmd.Parameters.AddWithValue("@PhoneNumber", user.PhoneNumber ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@BirthDate", user.BirthDate ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@IsActive", user.IsActive);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public void Delete(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_Delete", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public User ValidateUser(string email, string password)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetByEmail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", email);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();

        if (!dr.Read())
            return null;

        var user = new User
        {
            Id = Convert.ToInt32(dr["Id"]),
            Email = dr["Email"].ToString(),
            FirstName = dr["FirstName"].ToString(),
            LastName = dr["LastName"].ToString(),
            PhoneNumber = dr["PhoneNumber"].ToString(),
            PasswordHash = dr["PasswordHash"].ToString(),
            IsActive = Convert.ToBoolean(dr["IsActive"])
        };

        var hasher = new PasswordHasher<object>();
        var result = hasher.VerifyHashedPassword(
            null,
            user.PasswordHash,
            password
        );

        if (result == PasswordVerificationResult.Success)
            return user;

        return null;
    }

    private User MapUser(SqlDataReader dr)
    {
        return new User
        {
            Id = Convert.ToInt32(dr["Id"]),
            FirstName = dr["FirstName"].ToString(),
            LastName = dr["LastName"].ToString(),
            Email = dr["Email"].ToString(),
            PhoneNumber = dr["PhoneNumber"]?.ToString(),
            BirthDate = dr["BirthDate"] as DateTime?,
            IsActive = Convert.ToBoolean(dr["IsActive"])
        };
    }

    public bool IsEmailExists(string email)
    {
        return false;
    }
}
