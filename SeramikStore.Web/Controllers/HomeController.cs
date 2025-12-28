using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Logging;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Filters;
using SeramikStore.Web.Models;
using SeramikStore.Web.ViewModels;
using System.Diagnostics;

namespace SeramikStore.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private IProductService _productservices;
        private ICartService _cartservices;

        public HomeController(ILogger<HomeController> logger, IProductService productservices, ICartService cartservices)
        {
            _logger = logger;
            _productservices = productservices;
            _cartservices = cartservices;
        }

        public IActionResult Index()
        {
            var productList = _productservices.ProductList();
            List<ProductForListingViewModel> vm = new List<ProductForListingViewModel>();
            foreach (var item in productList)
            {
                vm.Add(new ProductForListingViewModel
                {
                    Id = item.Id,
                    ProductName = item.ProductName,
                    ProductCode = item.ProductCode,
                    AvailableForSale = item.AvailableForSale,
                    CategoryId = item.CategoryId,
                    UnitPrice = item.UnitPrice,
                    ProductDesc = item.ProductDesc,
                }

                );

            }

            return View(vm);
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
            }
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
            Cart cart = new Cart();
            cart.ProductId = vm.Id;
            cart.ProductName = vm.ProductName;
            cart.ProductCode = vm.ProductCode;
            cart.Quantity = vm.Quantity;
            cart.UnitPrice = vm.UnitPrice;
            //var total = (cart.Quantity) * (cart.UnitPrice);
            //cart.TotalAmount = total;
            cart.UserId = (int)HttpContext.Session.GetInt32("userId");
            int result = _cartservices.SaveCart(cart);
            if (result > 0)
            {
                HttpContext.Session.SetInt32("sessionCart", _cartservices.CartListByUserId(cart.UserId).Count());
                return RedirectToAction("Index", "Carts");
            }
            return RedirectToAction("Index", "Home");

        }
    }
}
