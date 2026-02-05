using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Services.Email;
using SeramikStore.Web.Localization;
using SeramikStore.Web.ViewModels;
using SeramikStore.Web.ViewModels.Account;

public class AccountController : Controller
{
    private readonly IUserService _userService;
    private readonly IEmailService _emailService;
    private readonly ICartService _cartService;
    private readonly IStringLocalizer<AccountResource> _L;

    public AccountController(IUserService userService, IEmailService emailService,
        IStringLocalizer<AccountResource> L, ICartService cartService)
    {
        _userService = userService;
        _emailService = emailService;
        _L = L;
        _cartService = cartService;
    }

    // REGISTER – GET
    [HttpGet]
    public IActionResult Register()
    {
        return View(new RegisterViewModel());
    }

    [HttpPost]
    public async Task<IActionResult> Register(RegisterViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

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
            new { token, email = model.Email },
            Request.Scheme
        );

        
        _ = Task.Run(async () =>
        {
            try
            {
                await _emailService.SendAsync(
                    model.Email,
                    "Email Doğrulama",
                    $"Email adresinizi doğrulamak için <a href='{confirmLink}'>buraya tıklayın</a>"
                );
            }
            catch (Exception ex)
            {
                // LOG AL ama kullanıcıyı bekletme
                //_logger.LogError(ex, "Email gönderilemedi");
            }
        });


        TempData["Success"] = "Kayıt başarılı. Email adresinizi doğrulayın.";
        return RedirectToAction("Login", "Account");
    }

    [HttpGet]
    public IActionResult ConfirmEmail(string email, string token)
    {
        if (email == null)
        {
            return RedirectToAction("Login");
        }

        var user = _userService.GetByEmail(email);

        if (user == null)
            return View("EmailConfirmResult", _L["Kullanıcı bulunamadı"].Value);

        if (user.IsEmailConfirmed)
            return View("EmailConfirmResult", _L["Email zaten doğrulanmış"].Value);

        if (user.EmailConfirmToken != token)
            return View("EmailConfirmResult", _L["Geçersiz doğrulama linki"].Value);

        if (user.EmailConfirmTokenExpire < DateTime.UtcNow)
            return View("EmailConfirmResult", _L["Doğrulama linkinin süresi dolmuş"].Value);

        _userService.ConfirmEmail(user.Id);

        return View("EmailConfirmResult", _L["Email başarıyla doğrulandı"].Value);
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

        // 🛒 ANON SEPET VAR MI?
        if (Request.Cookies.TryGetValue("cart_id", out var cartToken))
        {
            _cartService.MergeAnonymousCartToUser(cartToken, user.Id);

            // cookie'yi temizle
            Response.Cookies.Delete("cart_id");
        }

        if (vm.RememberMe)
        {
            var token = Guid.NewGuid().ToString("N");

                _userService.SetRememberMeToken(
                user.Id,
                token,
                DateTime.UtcNow.AddDays(30)
            );

            Response.Cookies.Append(
                "remember_me",
                token,
                new CookieOptions
                {
                    Expires = DateTimeOffset.UtcNow.AddDays(30),
                    HttpOnly = true,
                    Secure = true,
                    SameSite = SameSiteMode.Strict
                }
            );
        }


        return RedirectToAction("Index", "Home");

    }

    public IActionResult Logout()
    {
        // Tüm session'ları temizler
        HttpContext.Session.Clear();

        var token = Request.Cookies["remember_me"];
        if (token != null)
        {
            _userService.ClearRememberMeToken(token);
            Response.Cookies.Delete("remember_me");
        }

        HttpContext.Session.Clear();
        return RedirectToAction("Login", "Account");
    }

    [HttpGet]
    public IActionResult ForgotPassword()
    {
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> ForgotPassword(ForgotPasswordViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        var user = _userService.GetByEmail(model.Email);
        if (user == null || !user.IsEmailConfirmed)
        {
            // güvenlik: kullanıcı var mı yok mu söyleme
            return View("ForgotPasswordConfirmation");
        }

        var token = Guid.NewGuid().ToString("N");
        _userService.SetResetPasswordToken(user.Id, token, DateTime.UtcNow.AddHours(1));

        var resetLink = Url.Action(
            "ResetPassword",
            "Account",
            new { email = model.Email, token },
            Request.Scheme
        );

        // 🔥 EMAIL HATA VERSE BİLE DEVAM ETSİN
        _ = Task.Run(async () =>
        {
            try
            {
                await _emailService.SendAsync(
                    model.Email,
                    "Şifre Sıfırlama",
                    $"<a href='{resetLink}'>Şifremi sıfırla</a>"
                );
            }
            catch { /* log */ }
        });

        return View("ForgotPasswordConfirmation");
    }

    [HttpGet]
    public IActionResult ResetPassword(string email, string token)
    {
        var user = _userService.GetByEmail(email);

        if (user == null ||
            user.ResetPasswordToken != token ||
            user.ResetPasswordTokenExpire < DateTime.UtcNow)
        {

            return View("ResetPasswordResult", _L["Geçersiz veya süreci geçmiş link"].Value);
        }

        return View(new ResetPasswordViewModel
        {
            Token = user.ResetPasswordToken,
            Email = email,
        });


    }

    [HttpPost]
    public IActionResult ResetPassword(ResetPasswordViewModel vm)
    {
        if (!ModelState.IsValid)
            return View(vm);

        var user = _userService.GetByEmail(vm.Email);

        if (user == null ||
            user.ResetPasswordToken != vm.Token ||
            user.ResetPasswordTokenExpire < DateTime.UtcNow)
        {
            return View("ResetPasswordResult", _L["Geçersiz veya süreci geçmiş link"].Value);
        }

        _userService.ResetPassword(user.Id, vm.Password);

        return View("ResetPasswordResult", _L["Şifreniz başarıyla güncellenmiştir"].Value);
    }



}
