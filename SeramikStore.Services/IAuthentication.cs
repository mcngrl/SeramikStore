using SeramikStore.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IAuthentication
    {
        int AddRole(string RoleName);
        List<Role> GetAllRoles();

        int AddUser(AuthenticatedUser user);

        AuthenticatedUser CheckUser(string userName, string password);
        Role GetRole(int RoleId);

        bool CheckUserExists(string userName, string password);
        AuthenticatedUser GetUserByUserId(int userId);

        int UpdateUserDetails(int id, string address, string contactNumber);
    }
}
