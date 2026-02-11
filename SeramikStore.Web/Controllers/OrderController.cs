using Microsoft.AspNetCore.Mvc;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.ViewModels;

namespace SeramikStore.Web.Controllers
{
    public class OrderController : Controller
    {

        private readonly IOrderService _orderService;
        private readonly IUserAddressService _userAddressService;
        private readonly ICartService _cartService;

        public OrderController(IOrderService orderService,
            IUserAddressService userAddressService,
            ICartService cartService)
        {
            _orderService = orderService;
            _userAddressService = userAddressService;
            _cartService = cartService;
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


        public IActionResult PaymentInfo(int SelectedAddressId)
        {
            int userId = (int)HttpContext.Session.GetInt32("userId");


            // 1️⃣ Cart özet
            var cartResult = _cartService.CartListByUserId(userId);

            List<CartItem> CartListItems = new List<CartItem>();
            foreach (var item in cartResult.Items)
            {
                CartItem ci = new CartItem();
                ci.ProductDesc = "";
                ci.Quantity = item.Quantity;
                ci.UnitPrice = item.UnitPrice;
                ci.ProductId = item.ProductId;
                ci.ProductName = item.ProductName;
                ci.ProductCode = item.ProductCode;
                ci.Id = item.Id;
                ci.LineTotal = item.LineTotal;
                CartListItems.Add(ci);
            }

            // 2️⃣ Adres
            var address = _userAddressService.GetById(SelectedAddressId);

            UserAddressViewModel advm = new UserAddressViewModel();
            advm.Ad = address.Ad;
            advm.Adres = address.Adres;
            advm.Id = address.Id;
            advm.Baslik = address.Baslik;


            // 3️⃣ ViewModel
            var vm = new OrderPaymentInfoViewModel
            {
                Items = CartListItems,
                Address = advm,
                TotalAmount = cartResult.Summary.TotalAmount,
                CargoAmount = cartResult.Summary.CargoAmount,
                GrandTotal = cartResult.Summary.GrandTotal,

                Iban = "TR12 0006 2000 1234 5678 9012 34",
                BankName = "Ziraat Bankası"
            };

            return View(vm);
        }
    }

        //    [HttpPost]
        //    public IActionResult PaymentInfo(AddressSelectViewModel model)
        //    {
        //        if (!ModelState.IsValid)
        //        {
        //            // ❗ Adresler tekrar doldurulmalı
        //            model.Addresses = _userAddressService.GetByUserId(
        //                (int)HttpContext.Session.GetInt32("userId")
        //            );

        //            return View("~/Views/Cart/AddressDetail.cshtml", model);
        //        }

        //        int userId = (int)HttpContext.Session.GetInt32("userId");

        //        // 🛒 Cart
        //        var cartResult = _cartService.CartListByUserId(userId);

        //        // 📦 Address
        //        var address = _userAddressService.GetById(model.SelectedAddressId.Value);

        //        // ➜ PaymentInfo ViewModel oluştur
        //        var vm = new OrderPaymentInfoViewModel
        //        {
        //            Items = cartResult.Items.Select(item => new CartItem
        //            {
        //                ProductId = item.ProductId,
        //                ProductName = item.ProductName,
        //                ProductCode = item.ProductCode,
        //                Quantity = item.Quantity,
        //                UnitPrice = item.UnitPrice,
        //                LineTotal = item.LineTotal
        //            }).ToList(),

        //            Address = new UserAddressViewModel
        //            {
        //                Id = address.Id,
        //                Baslik = address.Baslik,
        //                Ad = address.Ad,
        //                Adres = address.Adres
        //            },

        //            TotalAmount = cartResult.Summary.TotalAmount,
        //            CargoAmount = cartResult.Summary.CargoAmount,
        //            GrandTotal = cartResult.Summary.GrandTotal,
        //            Iban = "TR12 0006 2000 1234 5678 9012 34",
        //            BankName = "Ziraat Bankası"
        //        };

        //        return View(vm);
        //    }


        //}
    }
