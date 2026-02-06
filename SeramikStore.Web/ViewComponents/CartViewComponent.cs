using SeramikStore.Entities;
using SeramikStore.Services;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.ViewComponents
{
    public class CartViewComponent : ViewComponent
    {
        private ICartService _cartService;

        public CartViewComponent(ICartService productService)
        {
            _cartService = productService;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {

            int count = 0;

            // ✅ LOGIN OLMUŞ KULLANICI
            var userId = HttpContext.Session.GetInt32("userId");
            if (userId.HasValue && userId.Value > 0)
            {

                var items = _cartService.CartListByUserId(userId.Value)?.Items;
                count = items?.Sum(x => x.Quantity) ?? 0;

                return View(count);
            }

            // ✅ LOGIN OLMAMIŞ (GUEST)
            if (Request.Cookies.TryGetValue("cart_id", out var cartId))
            {

                var items = _cartService.CartListByCartToken(cartId)?.Items;
                count = items?.Sum(x => x.Quantity) ?? 0;

            }

            return View(count);

        }
    }
}
