using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.Options;
using SeramikStore.Web.ViewModels;
using System.Globalization;

namespace SeramikStore.Web.Controllers
{
    public class OrderController : Controller
    {

        private readonly IOrderService _orderService;
        private readonly IUserAddressService _userAddressService;
        private readonly ICartService _cartService;
        private readonly CompanyOptions _company;
        public OrderController(IOrderService orderService,
            IUserAddressService userAddressService,
            ICartService cartService, IOptions<CompanyOptions> companyOptions)
        {
            _orderService = orderService;
            _userAddressService = userAddressService;
            _cartService = cartService;
            _company = companyOptions.Value;
        }

        public IActionResult Index()
        {
            int userId = (int)HttpContext.Session.GetInt32("userId");
            var orders = _orderService.GetOrdersByUserId(userId);
            return View(orders);
        }
        public IActionResult OrderInfo(int id)
        {
            var order = _orderService.GetOrderById(id);

            if (order == null)
                return NotFound();

            return View(order);
        }

        [HttpPost]
        public IActionResult CreateOrder(int AddressId, decimal CargoAmount)
        {
            int userId = (int)HttpContext.Session.GetInt32("userId");

            // 1️⃣ DTO hazırla
            OrderInfoDto orderInfo = new OrderInfoDto
            {
                UserId = userId,
                AddressId = AddressId,
                CargoAmount = CargoAmount
            };

            // 2️⃣ Order oluştur
            OrderCreateResultDto result = _orderService.CreateOrder(orderInfo);

            // 3️⃣ Başarılıysa OrderInfo sayfasına yönlendir
            return RedirectToAction("OrderInfo", new { id = result.OrderId });
        }

        [HttpGet]
        public IActionResult PaymentInfo()
        {
            var userId = HttpContext.Session.GetInt32("userId");
            var cartResult = _cartService.CartListByUserId(userId.Value);

            var addressId = HttpContext.Session.GetInt32("CheckoutAddressId");

            if (addressId == null)
                return RedirectToAction("AddressDetail", "Cart");

            var address = _userAddressService.GetById(addressId.Value);

            if (address == null || address.UserId != userId)
                return RedirectToAction("AddressDetail", "Cart");

    

            var vmPayment = new OrderPaymentInfoViewModel
            {
                Items = cartResult.Items.Select(item => new CartItem
                {
                    ProductId = item.ProductId,
                    ProductName = item.ProductName,
                    ProductCode = item.ProductCode,
                    Quantity = item.Quantity,
                    UnitPrice = item.UnitPrice,
                    LineTotal = item.LineTotal,
                    CurrencyCode = item.CurrencyCode,

                }).ToList(),
                Address = new UserAddressViewModel
                {
                    Id = address.Id,
                    Baslik = address.Baslik,
                    Ad = address.Ad,
                    Soyad = address.Soyad,
                    Adres = address.Adres,
                    Il = address.Il,
                    Ilce =address.Ilce,
                    Telefon = address.Telefon


                },
                TotalAmount = cartResult.Summary.TotalAmount,
                CargoAmount = cartResult.Summary.CargoAmount,
                GrandTotal = cartResult.Summary.GrandTotal,
                CurrencyCode = cartResult.Summary.CurrencyCode,


                Iban = _company.BankAccount.IBAN,
                BankName = _company.BankAccount.BankName,
                BankAccountHolder = _company.BankAccount.AccountHolder
            };



            return View("PaymentInfo", vmPayment);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult PaymentInfo(AddressSelectPostModel model)
        {
            //POST içinde asla return View(...) kullanma.

            var userId = HttpContext.Session.GetInt32("userId");

            var cartResult = _cartService.CartListByUserId(userId.Value);
            var addresses = _userAddressService.GetByUserId(userId.Value);

            if (!ModelState.IsValid)
            {
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
                    TotalAmount = cartResult.Summary.TotalAmount,
                    CargoAmount = cartResult.Summary.CargoAmount,
                    GrandTotal = cartResult.Summary.GrandTotal,
                    CurrencyCode = cartResult.Summary.CurrencyCode,
                };

                return View("~/Views/Cart/AddressDetail.cshtml", vm);
            }

            var address = _userAddressService.GetById(model.SelectedAddressId.Value);

            if (address == null || address.UserId != userId)
                return RedirectToAction("AddressDetail", "Cart");

            var vmPayment = new OrderPaymentInfoViewModel
            {
                Items = cartResult.Items.Select(item => new CartItem
                {
                    ProductId = item.ProductId,
                    ProductName = item.ProductName,
                    ProductCode = item.ProductCode,
                    Quantity = item.Quantity,
                    UnitPrice = item.UnitPrice,
                    LineTotal = item.LineTotal,
                    CurrencyCode = item.CurrencyCode,

                }).ToList(),
                Address = new UserAddressViewModel
                {
                    Id = address.Id,
                    Baslik = address.Baslik,
                    Ad = address.Ad,
                    Adres = address.Adres
                },
                TotalAmount = cartResult.Summary.TotalAmount,
                CargoAmount = cartResult.Summary.CargoAmount,
                GrandTotal = cartResult.Summary.GrandTotal,
                Iban = _company.BankAccount.IBAN,
                BankName = _company.BankAccount.BankName,
                BankAccountHolder = _company.BankAccount.AccountHolder
            };

            // Session'a kaydet (önemli!)
            HttpContext.Session.SetInt32("CheckoutAddressId", address.Id);

            return RedirectToAction("PaymentInfo");
        }


    }


}



