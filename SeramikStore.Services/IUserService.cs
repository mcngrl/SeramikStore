using SeramikStore.Entities;

public interface IUserService
{
    void Insert(User user, string plainPassword);
    void Update(User user);
    void Delete(int id);
    List<User> GetAll();
    User GetById(int id);
    User GetByEmail(string email);

    bool IsEmailExists(string email);

    User ValidateUser(string email, string password);
}
