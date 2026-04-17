using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json.Linq;
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
        cmd.Parameters.AddWithValue("@IsEmailConfirmed", user.IsEmailConfirmed); 
        cmd.Parameters.AddWithValue("@EmailConfirmCode", user.EmailConfirmCode); 
        cmd.Parameters.AddWithValue("@EmailConfirmCodeExpire", user.EmailConfirmCodeExpire);
        cmd.Parameters.AddWithValue("@EmailConfirmAttemptCount", user.EmailConfirmAttemptCount); 
        cmd.Parameters.AddWithValue("@EmailConfirmLastSentAt", user.EmailConfirmLastSentAt);

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

    public (int Result, string Message) Update(UserDto user)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_Update", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@Id", user.Id);
        cmd.Parameters.AddWithValue("@FirstName", user.FirstName);
        cmd.Parameters.AddWithValue("@LastName", user.LastName);
        cmd.Parameters.AddWithValue("@PhoneNumber", user.PhoneNumber ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@BirthDate", user.BirthDate ?? (object)DBNull.Value);
        cmd.Parameters.AddWithValue("@Email", user.Email);


        con.Open();


        using var reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            int result = reader.GetInt32(reader.GetOrdinal("Result"));
            string message = reader["Message"]?.ToString();

            return (result, message);
        }
        else
        {
            return (0, "Error");
        }
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
            FullName = dr["FullName"].ToString(),
            Avatar = dr["Avatar"].ToString(),
            Email = dr["Email"].ToString(),
            PasswordHash = dr["PasswordHash"].ToString(),
            PhoneNumber = dr["PhoneNumber"]?.ToString(),
            BirthDate = dr["BirthDate"] as DateTime?,
            IsActive = Convert.ToBoolean(dr["IsActive"]),
            RoleId = Convert.ToInt32(dr["RoleId"]),
            RoleName = dr["RoleName"].ToString(),
            IsEmailConfirmed = Convert.ToBoolean(dr["IsEmailConfirmed"]),
            EmailConfirmCode = dr["EmailConfirmCode"].ToString(),
            EmailConfirmCodeExpire = dr["EmailConfirmCodeExpire"] as DateTime?,
            EmailConfirmAttemptCount = Convert.ToInt32(dr["EmailConfirmAttemptCount"]),
            EmailConfirmLastSentAt = dr["EmailConfirmLastSentAt"] as DateTime?,


            ResetPasswordToken = dr["ResetPasswordToken"].ToString(),
            ResetPasswordTokenExpire = dr["ResetPasswordTokenExpire"] as DateTime?,
            RememberMeToken = dr["RememberMeToken"].ToString(),
            RememberMeExpire = dr["RememberMeExpire"] as DateTime?
        };
    }

    public bool IsEmailExists(string email)
    {
        using var conn = new SqlConnection(_connectionString);
        using var cmd = new SqlCommand("sp_User_IsEmailExists", conn);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;

        conn.Open();

        var result = cmd.ExecuteScalar();

        return Convert.ToInt32(result) == 1;
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

    public void ConfirmEmail(int userId)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_ConfirmEmail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);

        con.Open();
        cmd.ExecuteNonQuery();
    }


    public void SetResetPasswordToken(int userId, string token, DateTime expire)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_SetResetPasswordToken", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@Token", token);
        cmd.Parameters.AddWithValue("@Expire", expire);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public bool ResetPassword(int userId, string newPassword)
    {
        var user = GetById(userId);
        if (user == null) 
            return false;

        var newHash = _passwordHasher.HashPassword(user, newPassword);

        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_ResetPassword", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@PasswordHash", newHash);

        con.Open();
        cmd.ExecuteNonQuery();
        return true;
    }

    

    public void SetRememberMeToken(int userId, string token, DateTime expire)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_SetRememberMeToken", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.Parameters.AddWithValue("@Token", token);
        cmd.Parameters.AddWithValue("@Expire", expire);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public UserDto GetByRememberMeToken(string token)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("sp_User_GetByRememberMeToken", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Token", token);

        con.Open();
        using SqlDataReader dr = cmd.ExecuteReader();
        return dr.Read() ? MapUser(dr) : null;
    }

    public void ClearRememberMeToken(string token)
    {
        using SqlConnection con = new(_connectionString);
        using SqlCommand cmd = new("[sp_User_ClearRememberMeToken]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Token", token);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    public void ResendConfirmationEmail(string Email, string ConfirmCode, DateTime CodeExpire, int AttemptCount, DateTime LastSentAt)
    {
        using var conn = new SqlConnection(_connectionString);
        using var cmd = new SqlCommand("sp_User_ResendConfirmationEmail", conn);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@Email", Email);
        cmd.Parameters.AddWithValue("@EmailConfirmCode", ConfirmCode);
        cmd.Parameters.AddWithValue("@EmailConfirmCodeExpire", CodeExpire);
        cmd.Parameters.AddWithValue("@EmailConfirmAttemptCount", AttemptCount);
        cmd.Parameters.AddWithValue("@EmailConfirmLastSentAt", LastSentAt);


        conn.Open();
        cmd.ExecuteNonQuery();
    }
}
