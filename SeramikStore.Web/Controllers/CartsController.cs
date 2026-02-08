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



    }
}
