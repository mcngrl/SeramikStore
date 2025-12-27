using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Filters;
using SeramikStore.Web.ViewModel;

namespace SeramikStore.Web.Controllers
{
    public class CartsController : Controller
    {

        private ICartService _cartService;
        private IAuthentication _authenticationService;

        public CartsController(ICartService cartService, IAuthentication authenticationService)
        {
            _cartService = cartService;
            _authenticationService = authenticationService;
        }

        [CheckSession("userId")]
        public IActionResult Index()
        {
            var carts = _cartService.CartListByUserId((int)HttpContext.Session.GetInt32("userId"));
            return View(carts);
        }

        [HttpGet]
        [CheckSession("userId")]
        public IActionResult Edit(int id)
        {
            var cart = _cartService.CartGetById(id);
            return View(cart);
        }
        [HttpPost]
        public IActionResult Edit(Cart cart)
        {
            var totalAmount = (cart.Quantity) * (cart.UnitPrice);
            int result = _cartService.UpdateCart(cart.Id, cart.Quantity);
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
            var cart = _cartService.CartGetById(id);
            return View(cart);
        }

        [HttpPost]
        public IActionResult Delete(Cart cart)
        {
            int result = _cartService.CartDeleteById(cart.Id);
            if (result > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");

        }


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
