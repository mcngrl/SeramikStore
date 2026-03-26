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
            int userId = (int)HttpContext.Session.GetInt32("userId");
            var m = new ReturnCreateViewDto();
            m.OrderId = id;
            m.Items = _returnService.GetOrderForNewReturn(id, userId);
            return View(m);
        }

        [HttpPost]
        public IActionResult CreateReturn(ReturnCreateDto model)
        {
            model.UserId = (int)HttpContext.Session.GetInt32("userId");

            var result = _returnService.CreateReturn(model);

            if (result.Result > 0)
            {
                TempData["Success"] = result.Message;
            }
            else
            {
                TempData["Error"] = result.Message;
            }

            return RedirectToAction("GetReturnsByOrderId", new { id = model.OrderId });
        }
    }


}



