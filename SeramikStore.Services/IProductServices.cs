
using SeramikStore.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IProductServices
    {
        List<Product> ProductList();

        List<Cart> CartListByUserId(int userId);

        int CartDeleteById(int cartId);
        Cart CartGetById(int cartId);
        int UpdateCart(int cartId, decimal totalAmount, int quantity);

        int SaveCart(Cart cart);
        Product ProductGetById(int id);
    }
}
