using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using SeramikStore.Contracts.Order;
using SeramikStore.Contracts.Return;
using SeramikStore.Entities.Enums;
using SeramikStore.Services;
using SeramikStore.Web.Options;
using SeramikStore.Web.ViewModels;
using System.Globalization;

namespace SeramikStore.Web.Controllers
{
    public class ReturnController : Controller
    {
        private readonly IReturnService _returnService;
        private readonly IOrderService _orderService;
        private readonly IUserAddressService _userAddressService;
        private readonly ICartService _cartService;
        private readonly CompanyOptions _company;
        public ReturnController(
            IReturnService returnService,
            IOrderService orderService,
            IUserAddressService userAddressService,
            ICartService cartService, IOptions<CompanyOptions> companyOptions)
        {
            _returnService = returnService;
            _orderService = orderService;
            _userAddressService = userAddressService;
            _cartService = cartService;
            _company = companyOptions.Value;
        }

        [HttpGet]
        public IActionResult GetReturnsByOrderId(int id)
        {

            int userId = (int)HttpContext.Session.GetInt32("session_UserId");
            var returns = _returnService.GetReturnsByOrderId(id,userId);
            var m = new ReturnList();
            m.OrderId = id;
            m.Headers = returns;
            return View(m);
        }


        [HttpGet]
        public IActionResult NewReturn(int id)
        { 
            int userId = (int)HttpContext.Session.GetInt32("session_UserId");
            var m = new ReturnCreateViewDto();
            m.OrderId = id;
            m.Items = _returnService.GetOrderForNewReturn(id, userId);
            return View(m);
        }

        [HttpPost]
        public IActionResult CreateReturn(ReturnCreateDto model)
        {
            int userId = (int)HttpContext.Session.GetInt32("session_UserId");

            if (!model.Items.Any(x => x.ReturnQuantity > 0))
            {
                ModelState.AddModelError("Items", "En az bir ürün için iade adedi girilmelidir.");
            }

            if (model.Reason == "other")
            {
                ModelState.AddModelError("Reason", "Diğer seçeneği seçildiğinde açıklama girilmelidir.");
            }

            if (!ModelState.IsValid)
            {
              

                var vm = new ReturnCreateViewDto
                {
                    OrderId = model.OrderId,
                    Items = _returnService.GetOrderForNewReturn(model.OrderId, userId)
                };

                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => $"<li>{e.ErrorMessage}</li>")
                    .ToList();

                TempData["Required"] = $"<ul class='mb-0'>{string.Join("", errors)}</ul>";


                return View("NewReturn", vm);
            }

            model.UserId = (int)HttpContext.Session.GetInt32("session_UserId");

            var result = _returnService.CreateReturn(model);

            if (result.Result > 0)
            {
                TempData["Success"] = result.Message;
                return RedirectToAction("OrderInfo", "Order", new { id = model.OrderId });
            }
            else
            {


                var vm = new ReturnCreateViewDto
                {
                    OrderId = model.OrderId,
                    Items = _returnService.GetOrderForNewReturn(model.OrderId, userId)
                };


                TempData["Error"] = result.Message;


                return View("NewReturn", vm);
            }

            
        }
    }


}



