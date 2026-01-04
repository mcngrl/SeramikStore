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

        public CartsController(ICartService cartService)
        {
            _cartService = cartService;
            
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


        public IActionResult Increase(int id)
        {
            //_cartService.IncreaseQuantity(id);
            return RedirectToAction("Index");
        }

        public IActionResult Decrease(int id)
        {
            //_cartService.DecreaseQuantity(id);
            return RedirectToAction("Index");
        }

        //public IActionResult Delete(int id)
        //{
        //    //_cartService.Delete(id);
        //    //return RedirectToAction("Index");
        //}

    }


}
