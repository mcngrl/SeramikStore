using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.Filters;
using SeramikStore.Web.ViewModel;
using SeramikStore.Web.ViewModels;

namespace SeramikStore.Web.Controllers
{
    public class CartsController : Controller
    {

        private readonly IUserAddressService _userAddressService;
        private readonly ICartService _cartService;

        public CartsController(
            IUserAddressService userAddressService,
            ICartService cartService)
        {
            _userAddressService = userAddressService;
            _cartService = cartService;
        }

          public IActionResult Index()
        {
            var userId = HttpContext.Session.GetInt32("userId");
            CartResultDto cartResult;

            if (userId.HasValue)
            {
                // 👤 Login olmuş kullanıcı
                cartResult = _cartService.CartListByUserId(userId.Value);
            }
            else
            {
                // 🛒 Anon kullanıcı

                if (Request.Cookies.TryGetValue("cart_id", out var cartTokend))
                {
                    cartResult = _cartService.CartListByCartToken(cartTokend);
                }
                else
                {
                    cartResult = new CartResultDto();
                    cartResult.Summary = new CartSummaryDto();
                }

               
            }

            return View(cartResult);
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {

            var cart = _cartService.CartGetById(id);
            if (cart == null)
                return RedirectToAction("Index");

            var userId = HttpContext.Session.GetInt32("userId");

            if (userId.HasValue)
            {
                if (cart.UserId != userId.Value)
                    return Unauthorized();
            }
            else
            {
                var cartId = Request.Cookies["cart_id"];
                if (cart.cart_id_token != cartId)
                    return Unauthorized();
            }
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
        public IActionResult Delete(int id)
        {
    

            var cart = _cartService.CartGetById(id);
            if (cart == null)
                return RedirectToAction("Index");

            var userId = HttpContext.Session.GetInt32("userId");

            if (userId.HasValue)
            {
                if (cart.UserId != userId.Value)
                    return Unauthorized();
            }
            else
            {
                var cartId = Request.Cookies["cart_id"];
                if (cart.cart_id_token != cartId)
                    return Unauthorized();
            }


            return View(cart);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Delete(Cart cart)
        {

            var dbCart = _cartService.CartGetById(cart.Id);
            if (dbCart == null)
                return RedirectToAction("Index");

            var userId = HttpContext.Session.GetInt32("userId");
            if (userId.HasValue)
            {
                if (dbCart.UserId != userId.Value)
                    return Unauthorized();
            }
            else
            {
                var cartId = Request.Cookies["cart_id"];
                if (dbCart.cart_id_token != cartId)
                    return Unauthorized();
            }

            int result = _cartService.CartDeleteById(cart.Id);
            if (result > 0)
            {
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");



        }


        public IActionResult Increase(int id)
        {

            var cart = _cartService.CartGetById(id);
            if (cart == null)
                return RedirectToAction("Index");

            var userId = HttpContext.Session.GetInt32("userId");

            if (userId.HasValue)
            {
                if (cart.UserId != userId.Value)
                    return Unauthorized();
            }
            else
            {
                var cartId = Request.Cookies["cart_id"];
                if (cart.cart_id_token != cartId)
                    return Unauthorized();
            }

            //_cartService.IncreaseQuantity(id);
            return RedirectToAction("Index");
        }

        public IActionResult Decrease(int id)
        {

            var cart = _cartService.CartGetById(id);
            if (cart == null)
                return RedirectToAction("Index");

            var userId = HttpContext.Session.GetInt32("userId");

            if (userId.HasValue)
            {
                if (cart.UserId != userId.Value)
                    return Unauthorized();
            }
            else
            {
                var cartId = Request.Cookies["cart_id"];
                if (cart.cart_id_token != cartId)
                    return Unauthorized();
            }
            //_cartService.DecreaseQuantity(id);
            return RedirectToAction("Index");
        }

        //public IActionResult Delete(int id)
        //{
        //    //_cartService.Delete(id);
        //    //return RedirectToAction("Index");
        //}
        // 📌 Adres Seçme Sayfası
        [HttpGet]
        public IActionResult AddressDetail()
        {
 
            var userId = HttpContext.Session.GetInt32("userId");
            if (!userId.HasValue)
            {
                return RedirectToAction("Login", "Account",
                    new { returnUrl = Url.Action("AddressDetail", "Carts") });
            }


            var cartResult = _cartService.CartListByUserId((int)userId);

            var addresses = _userAddressService.GetByUserId((int)userId);

            var vm = new AddressSelectViewModel
            {
                Addresses = addresses.Select(a => new UserAddressViewModel
                {
                    Id = a.Id,
                    Ad = a.Ad,
                    Soyad = a.Soyad,
                    Telefon = a.Telefon,
                    Il = a.Il,
                    Ilce = a.Ilce,
                    Mahalle = a.Mahalle,
                    Adres = a.Adres,
                    Baslik = a.Baslik,
                    IsDefault = a.IsDefault
                }).ToList(),

                SelectedAddressId = addresses
                    .FirstOrDefault(x => x.IsDefault)?.Id ?? 0,


                ProductTotal = cartResult.Summary.TotalAmount,
                CargoPrice = cartResult.Summary.CargoAmount,
                GrandTotal = cartResult.Summary.GrandTotal,
            };

            return View(vm);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult AddressDetail(AddressSelectViewModel vm)
        {
            if (vm.SelectedAddressId == 0)
            {
                ModelState.AddModelError("", "Lütfen bir adres seçiniz");
                return View(vm);
            }

            // Seçilen adresi session’a al (checkout için)
            //HttpContext.Session.SetInt32(
            //    "SelectedAddressId",
            //    vm.SelectedAddressId
            //);

            // 👉 Sonraki adım: Ödeme


            return RedirectToAction("Payment");
        }

    }
}
