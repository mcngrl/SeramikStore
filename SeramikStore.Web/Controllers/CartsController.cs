using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Filters;
using SeramikStore.Web.ViewModel;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.Controllers
{
    public class CartsController : Controller
    {
        private IProductServices _productService;
        private IAuthentication _authenticationService;

        public CartsController(IProductServices productService, IAuthentication authenticationService)
        {
            _productService = productService;
            _authenticationService = authenticationService;
        }

        [CheckSession("userId")]
        public IActionResult Index()
        {
            var carts = _productService.CartListByUserId((int)HttpContext.Session.GetInt32("userId"));
            return View(carts);
        }

        [HttpGet]
        [CheckSession("userId")]
        public IActionResult Edit(int id)
        {
            var cart = _productService.CartGetById(id);
            return View(cart);
        }
        [HttpPost]
        public IActionResult Edit(Cart cart)
        {
            var totalAmount = (cart.Quantity) * (cart.UnitPrice);
            int result = _productService.UpdateCart(cart.Id, totalAmount, cart.Quantity);
            if (result > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");


        }

        [HttpGet]
        [CheckSession("userId")]
        public IActionResult Delete(int id)
        {
            var cart = _productService.CartGetById(id);
            return View(cart);
        }

        [HttpPost]
        public IActionResult Delete(Cart cart)
        {
            int result = _productService.CartDeleteById(cart.Id);
            if (result > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");

        }


        //[CheckSession("userId")]
        //public IActionResult AddToOrder()
        //{
        //    OrderDetail orderDetail = new OrderDetail();
        //    var userCart = _productService.GetCartDetailByUserId((int)HttpContext.Session.GetInt32("userId"));
        //    var result = _productService.AddCartToOrder(userCart);
        //    if (result == true)
        //    {
        //        int userId = (int)HttpContext.Session.GetInt32("userId");
        //        TempData["success"] = "Thanks For Your Order";
        //        _productService.DeleteAllCartItemsByUserId(userId);
        //        HttpContext.Session.SetInt32("sessionCart", _productService.GetCartDetailByUserId(userId).Count());
        //        return View("success");
        //    }
        //    return View(orderDetail);
        //}


        [CheckSession("userId")]
        public IActionResult AddressDetail(Decimal GrandTotal)
        {
            BillingDetailViewModel vm = new BillingDetailViewModel();
            var userDetail = _authenticationService.GetUserByUserId((int)HttpContext.Session.GetInt32("userId"));
            vm.Address = userDetail.Address;
            vm.GrandTotal = GrandTotal;
            return View(vm);

        }

        [CheckSession("userId")]
        public IActionResult ChangeAddress()
        {
            UserViewModel vm = new UserViewModel();
            var userDetail = _authenticationService.GetUserByUserId((int)HttpContext.Session.GetInt32("userId"));
            vm.Id = userDetail.Id;
            vm.UserName = userDetail.UserName;
            vm.Address = userDetail.Address;
            vm.TelephoneNumber = userDetail.TelephoneNumber;
            return View(vm);
        }
        [HttpPost]
        public IActionResult ChangeAddress(UserViewModel vm)
        {
            int result = _authenticationService.UpdateUserDetails(vm.Id, vm.Address, vm.TelephoneNumber);
            if (result > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");


        }
    }


}
