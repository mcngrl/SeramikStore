using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Logging;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.Filters;
using SeramikStore.Web.Models;
using SeramikStore.Web.ViewModels;
using System.Diagnostics;
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
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        [CheckSession("userName")]
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

            Cart cart = new Cart {
                ProductId = product.Id,
                ProductName = product.ProductName,
                ProductCode = product.ProductCode,
                Quantity = vm.Quantity,
                UnitPrice = product.UnitPrice,
            };
     
 

            cart.UserId = (int)HttpContext.Session.GetInt32("userId");
            int result = _cartservices.SaveCart(cart);
            if (result > 0)
            {
                HttpContext.Session.SetInt32("sessionCart", _cartservices.CartListByUserId(cart.UserId).Items.Count());
                return RedirectToAction("Index", "Carts");
            }
            return RedirectToAction("Index", "Home");

        }


 

    }
}
