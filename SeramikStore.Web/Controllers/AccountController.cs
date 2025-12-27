using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Filters;
using SeramikStore.Web.ViewModel;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.Controllers
{
    public class AccountController : Controller
    {

        private IAuthentication _authencationService;

        public AccountController(IAuthentication authencationService)
        {
            _authencationService = authencationService;
        }
        [HttpGet]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login", "Account");

        }


        [HttpPost]
        //[CheckSession("userName")]
        public IActionResult Login(LoginViewModel vm)
        {
            if (_authencationService.CheckUserExists(vm.UserName, vm.Password))
            {
                var user = _authencationService.UserGetByUserNameAndPassword(vm.UserName, vm.Password);
                if (user !=null)
                {
                    var role = _authencationService.RoleGetById(user.RoleId);
                    HttpContext.Session.SetString("userName", user.Name);
                    HttpContext.Session.SetString("role", role.Name);
                    HttpContext.Session.SetString("userName", user.Name);
                    HttpContext.Session.SetInt32("userId", user.Id);
                    
                    return RedirectToAction("Index", "Home");

                }
            }
            return View();
        }



        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(AuthenticatedUser model)
        {
            int a = 1;
            model.UserName = model.Email;
            var result = _authencationService.AddUser(model);
            if (result>0) {
                return RedirectToAction("Login");
            }
            return View();
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }
    }
}
