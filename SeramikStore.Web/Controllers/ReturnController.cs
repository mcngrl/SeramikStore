using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using SeramikStore.Contracts.Order;
using SeramikStore.Contracts.Reason;
using SeramikStore.Contracts.Return;
using SeramikStore.Entities.Enums;
using SeramikStore.Services;
using SeramikStore.Web.Options;
using SeramikStore.Web.ViewModels;
using SeramikStore.Web.ViewModels.Return;
using System.Globalization;

namespace SeramikStore.Web.Controllers
{
    public class ReturnController : Controller
    {
        private readonly IReturnService _returnService;
        private readonly IReasonService _reasonService;
        private readonly IOrderService _orderService;
        private readonly IUserAddressService _userAddressService;
        private readonly ICartService _cartService;
        private readonly CompanyOptions _company;
        public ReturnController(
            IReturnService returnService,
            IReasonService reasonService,
            IOrderService orderService,
            IUserAddressService userAddressService,
            ICartService cartService, IOptions<CompanyOptions> companyOptions)
        {
            _reasonService = reasonService;
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
            ReturnCreateViewModel m = EmptyReturnCreateVM(id, userId);
            if (m.Items == null || m.Items.Count == 0)
            {
                TempData["Error"] = "Bu sipariş için iade edilebilecek ürün bulunmamaktadır.";
                return RedirectToAction("OrderInfo", "Order", new { id });
            }
            return View(m);
                  
        }

        [HttpPost]
        public IActionResult CreateReturn(ReturnCreateViewModel model)
        {
            int userId = (int)HttpContext.Session.GetInt32("session_UserId");


            if (model.Items==null)
            {
                ModelState.AddModelError("Items", "İade edilebilecek ürün yok.");
            }
            else if (!model.Items.Any(x => x.ReturnQuantity > 0))
            {
                ModelState.AddModelError("Items", "En az bir ürün için iade adedi girilmelidir.");
            }
     
            if (model.ReasonId == 0)
            {

                ModelState.AddModelError("ReasonId", "İade sebebi seçiniz.");
                //if(model.ReturnReason.IsCustom==true)
                //{ 
                //    if (string.IsNullOrWhiteSpace(model.ReturnReason.Reasondesc))
                //    {
                //        ModelState.AddModelError("ReasonDesc", "Diğer seçeneği seçildiğinde açıklama girilmelidir.");
                //    }
                //}
            }
            else
            {
                ReasonDto selectedReason = _reasonService.GetById(model.ReasonId);
                if (selectedReason == null)
                {
                    ModelState.AddModelError("ReasonId", "Geçersiz iade sebebi seçimi.");
                }
                else if (selectedReason.IsCustom == true && string.IsNullOrWhiteSpace(model.Reasondesc))
                {
                    ModelState.AddModelError("Reasondesc", selectedReason.Reasondesc + " seçeneği seçildiğinde açıklama girilmelidir.");
                }
            }

            if (!ModelState.IsValid)
            {

                ReturnCreateViewModel vm = EmptyReturnCreateVM(model.OrderId, userId);

                var errors = ModelState.Values
                    .SelectMany(v => v.Errors)
                    .Select(e => $"<li>{e.ErrorMessage}</li>")
                    .ToList();

                TempData["Required"] = $"<ul class='mb-0'>{string.Join("", errors)}</ul>";


                return View("NewReturn", vm);
            }
            if (string.IsNullOrWhiteSpace(model.Reasondesc))
            {
                model.Reasondesc = string.Empty;
            }
            ReturnCreateDto mo = new ReturnCreateDto
            {
                OrderId = model.OrderId,
                UserId = userId,
                ReturnReason = new ReasonDto
                {
                    Id = model.ReasonId,
                    Reasondesc = model.Reasondesc
                },
                Items = model.Items.Select(x => new ReturnItemDto
                {
                    OrderDetailId = x.OrderDetailId,
                    ReturnQuantity = x.ReturnQuantity
                }).ToList()
            };

            var result = _returnService.CreateReturn(mo);

            if (result.Result > 0)
            {
                TempData["Success"] = result.Message;
                TempData["LastReturnId"] = result.Result;

                return RedirectToAction("OrderInfo", "Order", new { id = model.OrderId });
            }
            else
            {
                var vm = EmptyReturnCreateVM(model.OrderId, userId);
                TempData["Error"] = result.Message;
                return View("NewReturn", vm);
            }
            
        }



        [HttpPost]
        public IActionResult CancelMyReturn(int ReturnHeaderid, int OrderId)
        {

            var userId = HttpContext.Session.GetInt32("session_UserId");

            if (userId is null)
                return RedirectToAction("Index", "Home");



            var res = _returnService.CancelReturn(ReturnHeaderid, (int)userId);

            if (res.Result > 0)
            {
                TempData["Success"] = res.Message;
                TempData["LastReturnId"] = res.Result;
            }
            else
            {
                TempData["Error"] = res.Message;
            }

            return RedirectToAction("OrderInfo", "Order", new { id = OrderId });



        }
        public ReturnCreateViewModel EmptyReturnCreateVM(int orderid, int userId)
        {
            var m = new ReturnCreateViewModel();
            m.OrderId = orderid;
            m.Reasondesc = "";
            m.ReasonId = 0;

            m.Items = _returnService.GetOrderForNewReturn(orderid, userId);
            m.Reasons = new List<SelectListItem>
{
            new SelectListItem
            {
                Value = "0",
                Text = "Lütfen Seçiniz"
            }
}
            .Concat(_reasonService.List()
                .Select(x => new SelectListItem
                {
                    Value = x.Id.ToString(),
                    Text = $"{x.Id} - {x.Reasondesc}"
                }))
            .ToList();

            return m;
        }
    }


}



