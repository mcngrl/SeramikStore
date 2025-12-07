using Microsoft.AspNetCore.Mvc;
using SeramikStore.Services;
using SeramikStore.Web.Models;
using System.Diagnostics;
using SeramikStore.Web.ViewModels;
using Microsoft.IdentityModel.Logging;

namespace SeramikStore.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private IProductServices _productservices;

        public HomeController(ILogger<HomeController> logger, IProductServices productservices)
        {
            _logger = logger;
            _productservices = productservices;
        }

        public IActionResult Index()
        {
            var productList = _productservices.GetListOfProducts();
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
                    Currency = item.Currency,
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
            var TheProduct = _productservices.GetProductById(id);

            if (TheProduct.Id != 0)
            {

                vm.ProductDesc = TheProduct.ProductDesc;
                vm.ProductCode = TheProduct.ProductCode;
                vm.ProductName = TheProduct.ProductName;
                vm.UnitPrice = TheProduct.UnitPrice;
                vm.CategoryId = TheProduct.CategoryId;
                vm.Currency = TheProduct.Currency;
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
    }
}
