using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
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

        [CheckSession("userId")]
        public IActionResult Index()
        {
            var cartResult = _cartService.CartListByUserId((int)HttpContext.Session.GetInt32("userId"));
            return View(cartResult);
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
        // 📌 Adres Seçme Sayfası
        [HttpGet]
        public IActionResult AddressDetail()
        {
            int userId = HttpContext.Session.GetInt32("userId").Value;
            var cartResult = _cartService.CartListByUserId(userId);

            var addresses = _userAddressService.GetByUserId(userId);

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
