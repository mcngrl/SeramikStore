using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using SeramikStore.Entities;
using System.Data;

namespace SeramikStore.Services
{
    public class AuthenticationService : IAuthentication
    {
        private string connectionString = String.Empty;
        public AuthenticationService(IConfiguration config)
        {
            connectionString = config.GetConnectionString("DefaultConnection");
        }

        public int AddRole(string RoleName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string Query = "INSERT INTO [Role](name)Values(@RoleName)";
                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@RoleName", RoleName);
                    int result = command.ExecuteNonQuery();
                    connection.Close();
                    return result;
                }

            }
        }

        public int AddUser(AuthenticatedUser user)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string Query = "Insert into [UserTable](UserName, Email, Password, Name, TelephoneNumber,Address,RoleId)" +
                    "values(@userName,@email,@password,@name,@TelephoneNumber,@address,@roleId)";
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Parameters.AddWithValue("@name", user.Name);
                    cmd.Parameters.AddWithValue("@userName", user.UserName);
                    cmd.Parameters.AddWithValue("@email", user.Email);
                    cmd.Parameters.AddWithValue("@password", user.Password);
                    cmd.Parameters.AddWithValue("@TelephoneNumber", user.TelephoneNumber);
                    cmd.Parameters.AddWithValue("@address", user.Address);
                    cmd.Parameters.AddWithValue("@roleId", 2);
                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                    return result;
                }
            }
        }


        public AuthenticatedUser CheckUser(string userName, string password)
        {
            AuthenticatedUser authenticatedUser = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string Query = "SELECT * FROM [UserTable] WHERE UserName=@UserName and Password =@Password";
                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@Password", password);
                    var reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        authenticatedUser = new AuthenticatedUser();
                        authenticatedUser.UserName = reader["UserName"].ToString();
                        authenticatedUser.Email = reader["Email"].ToString();
                        authenticatedUser.Name = reader["Name"].ToString();
                        authenticatedUser.Id= Convert.ToInt32(reader["Id"].ToString());
                        authenticatedUser.RoleId = Convert.ToInt32(reader["RoleId"].ToString());
                    }

                 
                    connection.Close();
                    return authenticatedUser;
                }

            }
        }

        public bool CheckUserExists(string userName, string password)
        {
            bool flag = false;
            var user = CheckUser(userName, password);
            if (user != null) {
                flag = true;
            }
            return flag;
        }

        public List<Role> GetAllRoles()
        {
            List<Role> roles = new List<Role>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string Query = "SELECT * FROM [Role]";
                using (SqlCommand command = new SqlCommand(Query, connection))
                {
                    var reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        roles.Add(new Role
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Name"].ToString()
                        });

                    }
                    connection.Close();
                    return roles;
                }

            }
        }

        public AuthenticatedUser GetUserByUserId(int userId)
        {
            var authenticatedUser = new AuthenticatedUser();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string Query = "select * from [UserTable] where Id=@userId";
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);
                    var reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        authenticatedUser.Id = Convert.ToInt32(reader["Id"]);
                        authenticatedUser.UserName = reader["UserName"].ToString();
                        authenticatedUser.Name = reader["Name"].ToString();
                        authenticatedUser.Address = reader["Address"].ToString();
                        authenticatedUser.TelephoneNumber = reader["TelephoneNumber"].ToString();
                    }
                    con.Close();
                    return authenticatedUser;
                }
            }

        }

        public int UpdateUserDetails(int id, string address, string TelephoneNumber)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string Query = "Update [UserTable] set TelephoneNumber=@TelephoneNumber,Address=@address where Id=@id";
                using (SqlCommand cmd = new SqlCommand(Query, con))
                {
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Parameters.AddWithValue("@TelephoneNumber", TelephoneNumber);
                    cmd.Parameters.AddWithValue("@address", address);
                    cmd.Parameters.AddWithValue("@id", id);

                    int result = cmd.ExecuteNonQuery();
                    con.Close();
                    return result;
                }
            }
        }




        List<Role> IAuthentication.GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public Role RoleGetById(int roleId)
        {
            Role role = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_RoleGetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@RoleId", roleId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            role = new Role
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Name = reader["Name"].ToString()
                            };
                        }
                    }
                }

                connection.Close();
            }

            return role;
        }


        public AuthenticatedUser UserGetByUserNameAndPassword(string userName, string password)
        {
            AuthenticatedUser authenticatedUser = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("sp_UserGetByUserNameAndPassword", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@Password", password);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            authenticatedUser = new AuthenticatedUser
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                UserName = reader["UserName"].ToString(),
                                Email = reader["Email"].ToString(),
                                Name = reader["Name"].ToString(),
                                RoleId = Convert.ToInt32(reader["RoleId"])
                            };
                        }
                    }
                }

                connection.Close();
            }

            return authenticatedUser;


        }
    }
}
