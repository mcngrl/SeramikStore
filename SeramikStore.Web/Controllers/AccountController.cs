using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.ViewModel;
using SeramikStore.Web.ViewModels;

public class AccountController : Controller
{
    private readonly IUserService _userService;

    public AccountController(IUserService userService)
    {
        _userService = userService;
    }

    // REGISTER – GET
    [HttpGet]
    public IActionResult Register()
    {
        return View(new RegisterViewModel());
    }

    // REGISTER – POST
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Register(RegisterViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        // Email daha önce var mı?
        if (_userService.IsEmailExists(model.Email))
        {
            ModelState.AddModelError("Email", "Bu email adresi zaten kayıtlı");
            return View(model);
        }

        var user = new User
        {
            FirstName = model.FirstName,
            LastName = model.LastName,
            Email = model.Email,
            PhoneNumber = model.PhoneNumber,
            BirthDate = model.BirthDate
        };

        _userService.Insert(user, model.Password);

        TempData["Success"] = "Kayıt başarılı. Giriş yapabilirsiniz.";
        return RedirectToAction("Login", "Account");
    }

    [HttpGet]
    public IActionResult Login()
    {
        return View();
    }

    [HttpPost]
    //[CheckSession("userName")]
    public IActionResult Login(LoginViewModel vm)
    {

            var user = _userService.ValidateUser(vm.UserName, vm.Password);
            if (user != null)
            {
                //var role = _authencationService.RoleGetById(user.RoleId);
                //HttpContext.Session.SetString("userName", user.Name);
                //HttpContext.Session.SetString("role", role.Name);
                HttpContext.Session.SetString("userName", user.FirstName );
                HttpContext.Session.SetInt32("userId", user.Id);

                return RedirectToAction("Index", "Home");

            }

        return View();
    }
}
