using SeramikStore.Entities;
using SeramikStore.Services.DTOs;

public interface IUserService
{
    void Insert(UserDto user, string plainPassword);
    void Update(UserDto user);
    void Delete(int id);
    List<UserDto> GetAll();
    UserDto GetById(int id);
    UserDto GetByEmail(string email);
    bool IsEmailExists(string email);
    UserDto ValidateUser(string email, string password);
    bool ChangePassword(int userId, string currentPassword, string newPassword);
    void ConfirmEmail(int userId);
    void SetResetPasswordToken(int userId, string token, DateTime expire);
    bool ResetPassword(int userId, string newPassword);
    void SetRememberMeToken(int userId, string token, DateTime expire);
    UserDto GetByRememberMeToken(string token);
    void ClearRememberMeToken(string token);
}
