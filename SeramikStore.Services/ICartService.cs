using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface ICartService
    {
        CartResultDto CartListByUserId(int userId);
        Cart CartGetById(int cartId);
        int SaveCart(Cart cart);
        int UpdateCart(int cartId, int quantity);
        int CartDeleteById(int cartId);
    }
}
