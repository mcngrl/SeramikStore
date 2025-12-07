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
        List<Product> GetListOfProducts();

        List<Cart> GetCartDetailByUserId(int userId);

        int DeleteCartById(int cartId);
        Cart GetCartById(int cartId);
        int UpdateCart(int cartId, decimal totalAmount, int quantity);
        Product GetProductById(int id);
    }
}
