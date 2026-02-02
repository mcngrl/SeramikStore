using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Web.ViewModels;
using SeramikStore.Web.ViewModels.Account;

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
        var token = Guid.NewGuid().ToString("N");

        var user = new UserDto
        {
            FirstName = model.FirstName,
            LastName = model.LastName,
            Email = model.Email,
            PhoneNumber = model.PhoneNumber,
            BirthDate = model.BirthDate,
            IsActive = true,
            IsEmailConfirmed = false,
            EmailConfirmToken = token,
            EmailConfirmTokenExpire = DateTime.UtcNow.AddHours(24),
            RoleId = 2,
            AcceptKvkk = model.AcceptKvkk,
            AcceptMembershipAgreement = model.AcceptMembershipAgreement,
            AgreementAcceptedIp = HttpContext.Connection.RemoteIpAddress?.ToString()
        };

        _userService.Insert(user, model.Password);

        var confirmLink = Url.Action(
        "ConfirmEmail",
        "Account",
        new { token = token, email = model.Email },
        Request.Scheme
        );
        //_emailService.Send(
        //model.Email,
        //"Email Doğrulama",
        //$"Email adresinizi doğrulamak için <a href='{confirmLink}'>buraya tıklayın</a>"
        //);

        TempData["Success"] = "Kayıt başarılı. Giriş yapabilirsiniz.";
        return RedirectToAction("Login", "Account");
    }

    [HttpGet]
    public IActionResult ConfirmEmail(string email, string token)
    {
        var user = _userService.GetByEmail(email);

        if (user == null)
            return View("EmailConfirmResult", "Kullanıcı bulunamadı");

        if (user.IsEmailConfirmed)
            return View("EmailConfirmResult", "Email zaten doğrulanmış");

        if (user.EmailConfirmToken != token)
            return View("EmailConfirmResult", "Geçersiz doğrulama linki");

        if (user.EmailConfirmTokenExpire < DateTime.UtcNow)
            return View("EmailConfirmResult", "Doğrulama linkinin süresi dolmuş");

        _userService.ConfirmEmail(user.Id);

        return View("EmailConfirmResult", "Email başarıyla doğrulandı 🎉");
    }



    [HttpGet]
    public IActionResult MyProfile()
    {

        return View();
    }

    [HttpGet]
    public IActionResult Profile()
    {
        int userId = HttpContext.Session.GetInt32("userId").Value;
        var user = _userService.GetById(userId);

        var vm = new ProfileViewModel
        {
            Profile = new ProfileInfoViewModel
            {
                Id = user.Id,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                PhoneNumber = user.PhoneNumber,
                BirthDate = user.BirthDate
            },
            Password = new ChangePasswordViewModel()
        };

        return View(vm);
    }



    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Profile(ProfileViewModel vm, string FormType)
    {
        int userId = HttpContext.Session.GetInt32("userId").Value;

        if (FormType == "Profile")
        {
            ModelState.Remove("Password");

            if (!ModelState.IsValid)
                return View(vm);

            _userService.Update(new UserDto
            {
                Id = userId,
                FirstName = vm.Profile.FirstName,
                LastName = vm.Profile.LastName,
                PhoneNumber = vm.Profile.PhoneNumber,
                BirthDate = vm.Profile.BirthDate
            });

            TempData["Success"] = "Profil bilgileri güncellendi";
            return RedirectToAction("Profile");
        }

        if (FormType == "Password")
        {
            ModelState.Remove("Profile");

            if (!ModelState.IsValid)
                return View(vm);

            bool result = _userService.ChangePassword(
                userId,
                vm.Password.CurrentPassword,
                vm.Password.NewPassword
            );

            if (!result)
            {
                ModelState.AddModelError(
                    "Password.CurrentPassword",
                    "Şu anki şifre hatalı"
                );

                var user = _userService.GetById(userId);
                vm.Profile = new ProfileInfoViewModel
                {
                    Id = user.Id,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    BirthDate = user.BirthDate
                };

                return View(vm);
            }

            TempData["Success"] = "Şifre başarıyla değiştirildi";
            return RedirectToAction("Profile");
        }

        return View(vm);
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

        if (!ModelState.IsValid)
            return View(vm);

        var user = _userService.ValidateUser(vm.UserName, vm.Password);

        if (user == null)
        {
            ModelState.AddModelError(string.Empty, "Kullanıcı adı veya şifre hatalı");
            return View(vm);
        }

        if (!user.IsEmailConfirmed)
        {
            ModelState.AddModelError("", "Email adresinizi doğrulamanız gerekiyor");
            return View(vm);
        }
        HttpContext.Session.SetString("userName", user.Email);
        HttpContext.Session.SetString("role", user.RoleName);
        HttpContext.Session.SetInt32("userId", user.Id);

        return RedirectToAction("Index", "Home");
    }


    public IActionResult Logout()
    {
        // Tüm session'ları temizler
        HttpContext.Session.Clear();

        // Login ekranına yönlendir
        return RedirectToAction("Login", "Account");
    }
}
