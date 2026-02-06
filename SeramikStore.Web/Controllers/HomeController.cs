using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Logging;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.Filters;
using SeramikStore.Web.Models;
using SeramikStore.Web.ViewModels;
using System.Diagnostics;
using System.Globalization;
using System.Net.WebSockets;
using System.Runtime.Intrinsics.X86;

namespace SeramikStore.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private IProductService _productservices;
        private ICartService _cartservices;
        private IProductImageService _productimageservice;

        public HomeController(ILogger<HomeController> logger, IProductService productservices, ICartService cartservices, IProductImageService productimageservice)
        {
            _logger = logger;
            _productservices = productservices;
            _cartservices = cartservices;
            _productimageservice = productimageservice;
        }

        public IActionResult Index()
        {
            List<ProductListForHomeDto> productList = _productservices.ProductList();
            return View(productList);
        }

        public IActionResult Details(int id)
        {
            ProductDetail vm = new ProductDetail();
            var TheProduct = _productservices.ProductGetById(id);

            if (TheProduct.Id != 0)
            {

                vm.ProductDesc = TheProduct.ProductDesc;
                vm.ProductCode = TheProduct.ProductCode;
                vm.ProductName = TheProduct.ProductName;
                vm.UnitPrice = TheProduct.UnitPrice;
                vm.CategoryId = TheProduct.CategoryId;
                vm.CurrencyCode = TheProduct.CurrencyCode;
                vm.CurrencySymbol = TheProduct.CurrencySymbol;
                vm.CategoryName = TheProduct.CategoryName;
                
            }

            var images = _productimageservice.GetByProductId(id);

            List<string> ImagePaths = new List<string>();
            foreach (var image in images) 
            {
                ImagePaths.Add(image.ImagePath);  
             };
            vm.ImagePaths = ImagePaths;
            return View(vm);
        }
        public IActionResult PrivacyTR()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "en")
            {
                return RedirectToAction(nameof(PrivacyEN));
            }

            return View(); 
        }

        public IActionResult PrivacyEN()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "tr")
            {
                return RedirectToAction(nameof(PrivacyTR));
            }

            return View();
        }
        public IActionResult KVKKTR()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "en")
            {
                return RedirectToAction(nameof(KVKKEN));
            }

            return View();
        }
        public IActionResult KVKKEN()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "tr")
            {
                return RedirectToAction(nameof(KVKKTR));
            }

            return View();
        }

        public IActionResult MesafeliSatisTR()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "en")
            {
                return RedirectToAction(nameof(MesafeliSatisEN));
            }

            return View();
        }
        public IActionResult MesafeliSatisEN()
        {
            var lang = CultureInfo.CurrentUICulture.TwoLetterISOLanguageName;

            if (lang == "tr")
            {
                return RedirectToAction(nameof(MesafeliSatisTR));
            }

            return View();
        }







        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        //[CheckSession("userName")]
        [HttpPost]
        public IActionResult Cart(ProductDetail vm)
        {
            if (vm.Quantity < 1)
            {
                ModelState.AddModelError("Quantity", "Adet en az 1 olmalıdır");

                var TheProduct = _productservices.ProductGetById(vm.Id);

                if (TheProduct.Id != 0)
                {

                    vm.ProductDesc = TheProduct.ProductDesc;
                    vm.ProductCode = TheProduct.ProductCode;
                    vm.ProductName = TheProduct.ProductName;
                    vm.UnitPrice = TheProduct.UnitPrice;
                    vm.CategoryId = TheProduct.CategoryId;
                    vm.CurrencyCode = TheProduct.CurrencyCode;
                    vm.CurrencySymbol = TheProduct.CurrencySymbol;
                    vm.CategoryName = TheProduct.CategoryName;

                }

                var images = _productimageservice.GetByProductId(vm.Id);

                List<string> ImagePaths = new List<string>();
                foreach (var image in images)
                {
                    ImagePaths.Add(image.ImagePath);
                }
                ;
                vm.ImagePaths = ImagePaths;
                return View("Details", vm);
            }


            var product = _productservices.ProductGetById(vm.Id);
            if (product == null) {
                return RedirectToAction("Index", "Home");
            }

            var userId = HttpContext.Session.GetInt32("userId");

            Cart cart = new Cart
            {
                ProductId = product.Id,
                ProductName = product.ProductName,
                ProductCode = product.ProductCode,
                Quantity = vm.Quantity,
                UnitPrice = product.UnitPrice,
                cart_id_token = GetOrCreateCartId(),
                UserId = userId
            };

            int result = _cartservices.SaveCart(cart);

            if (result > 0)
            {
                return RedirectToAction("Index", "Carts");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }

               
        }

        private string GetOrCreateCartId()
        {
            const string cookieName = "cart_id";

            if (Request.Cookies[cookieName] != null)
                return Request.Cookies[cookieName];

            var cartId = Guid.NewGuid().ToString("N");

            Response.Cookies.Append(
                cookieName,
                cartId,
                new CookieOptions
                {
                    Expires = DateTimeOffset.UtcNow.AddDays(30),
                    HttpOnly = true,
                    Secure = true,
                    SameSite = SameSiteMode.Lax
                });

            return cartId;
        }



    }
}
