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

            if (HttpContext.Session.GetInt32("userId") != null)
            {
                if (HttpContext.Session.GetString("sessionCart") != null)
                {
                    return View(HttpContext.Session.GetInt32("sessionCart"));
                }
                else
                {
                    int UserId = (int)HttpContext.Session.GetInt32("userId");
                    HttpContext.Session.SetInt32("sessionCart", _cartService.CartListByUserId(UserId).Items.Count());
                    return View(HttpContext.Session.GetInt32("sessionCart"));

                }
            }
            else 
            {
                HttpContext.Session.Clear();
                return View(0);
            }
            
        }
    }
}
