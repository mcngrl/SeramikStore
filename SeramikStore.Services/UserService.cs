using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System.Data;
public class UserService : IUserService
{
    private readonly string _connectionString;

    private readonly PasswordHasher<UserDto> _passwordHasher;

    public UserService(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
        _passwordHasher = new PasswordHasher<UserDto>();
    }

    public void Insert(UserDto user, string plainPassword)
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
        cmd.Parameters.AddWithValue("@IsActive", user.IsActive);
        cmd.Parameters.AddWithValue("@RoleId", user.RoleId);
        cmd.Parameters.AddWithValue("@AcceptMembershipAgreement", user.AcceptMembershipAgreement);
        cmd.Parameters.AddWithValue("@AcceptKvkk", user.AcceptKvkk);
        cmd.Parameters.AddWithValue("@AgreementAcceptedIp", user.AgreementAcceptedIp); 

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public List<UserDto> GetAll()
    {
        List<UserDto> list = new();
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

    public UserDto GetById(int id)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetById", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", id);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        return dr.Read() ? MapUser(dr) : null;
    }

    public UserDto GetByEmail(string email)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetByEmail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", email);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        return dr.Read() ? MapUser(dr) : null;
    }

    public void Update(UserDto user)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_Update", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@Id", user.Id);
        cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
        cmd.Parameters.AddWithValue("@LastName", user.LastName);
        cmd.Parameters.AddWithValue("@PhoneNumber", user.PhoneNumber ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@BirthDate", user.BirthDate ?? (object)DBNull.Value);

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

    public UserDto ValidateUser(string email, string password)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetByEmail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Email", email);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();

        if (!dr.Read())
            return null;

        var user = MapUser(dr);
  

        var hasher = new PasswordHasher<object>();
        var result = hasher.VerifyHashedPassword(
            user,
            user.PasswordHash,
            password
        );

        if (result == PasswordVerificationResult.Success)
            return user;

        return null;
    }

    private UserDto MapUser(SqlDataReader dr)
    {
        return new UserDto
        {
            Id = Convert.ToInt32(dr["Id"]),
            FirstName = dr["FirstName"].ToString(),
            LastName = dr["LastName"].ToString(),
            Email = dr["Email"].ToString(),
            PasswordHash = dr["PasswordHash"].ToString(),
            PhoneNumber = dr["PhoneNumber"]?.ToString(),
            BirthDate = dr["BirthDate"] as DateTime?,
            IsActive = Convert.ToBoolean(dr["IsActive"]),
            RoleId = Convert.ToInt32(dr["RoleId"]),
            RoleName = dr["RoleName"].ToString()
        };
    }

    public bool IsEmailExists(string email)
    {
        return false;
    }


    public bool ChangePassword(int userId, string currentPassword, string newPassword)
    {
        var user = GetById(userId);
        if (user == null) return false;

        var verify = _passwordHasher.VerifyHashedPassword(
            user,
            user.PasswordHash,
            currentPassword
        );

        if (verify != PasswordVerificationResult.Success)
            return false;

        var newHash = _passwordHasher.HashPassword(user, newPassword);

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_ChangePassword", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Id", userId);
        cmd.Parameters.AddWithValue("@PasswordHashNew", newHash);

        con.Open();
        cmd.ExecuteNonQuery();

        return true;
    }

}
