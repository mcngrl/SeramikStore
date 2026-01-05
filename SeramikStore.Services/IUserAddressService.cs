using SeramikStore.Entities;
using System.Collections.Generic;

namespace SeramikStore.Services
{
    public interface IUserAddressService
    {
        List<UserAddress> GetByUserId(int userId);
        UserAddress GetById(int id);

        void Insert(UserAddress address);
        void Update(UserAddress address);
        void Delete(int id);

     
    }
}
