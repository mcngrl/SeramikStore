using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public partial interface ICartService
    {
        CartResultDto CartListByUserId(int userId);

        CartItemDto Cart_GetById_withImage(int cartId);
        Cart CartGetById(int cartId);
        int SaveCart(Cart cart);
        int UpdateCart(int cartId, int quantity);
        int CartDeleteById(int cartId);
        CartResultDto CartListByCartToken(string cart_id_token);

        void MergeAnonymousCartToUser(string cartToken, int userId);

        void IncreaseQuantity(int cartId);
        void DecreaseQuantity(int cartId);
    }
}
