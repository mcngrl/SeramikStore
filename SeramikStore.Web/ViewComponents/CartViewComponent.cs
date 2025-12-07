using SeramikStore.Entities;
using SeramikStore.Services;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.ViewComponents
{
    public class CartViewComponent : ViewComponent
    {
        private IProductServices _productService;

        public CartViewComponent(IProductServices productService)
        {
            _productService = productService;
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
                    HttpContext.Session.SetInt32("sessionCart", _productService.GetCartDetailByUserId(UserId).Count());
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
