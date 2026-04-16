using Humanizer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;
using Microsoft.Extensions.Options;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Services.DTOs;
using SeramikStore.Services.Email;
using SeramikStore.Web.Localization;
using SeramikStore.Web.Options;
using SeramikStore.Web.ViewModels;
using SeramikStore.Web.ViewModels.Account;
using System.Globalization;
using System.Net;
using System.Net.Mail;

public class AccountController : Controller
{
    private readonly IUserService _userService;
    private readonly IEmailService _emailService;
    private readonly ICartService _cartService;
    private readonly IStringLocalizer<AccountResource> _L;
    private readonly IStringLocalizer<EmailResource> _emailL;
    private readonly CompanyOptions _company;

    private readonly EmailSettings _settings;

    public AccountController(IUserService userService, IEmailService emailService,
        IStringLocalizer<AccountResource> L, ICartService cartService,
        IStringLocalizer<EmailResource> emailL, IOptions<CompanyOptions> companyOptions,
        IOptions<EmailSettings> settings)
    {
        _userService = userService;
        _emailService = emailService;
        _L = L;
        _cartService = cartService;
        _emailL = emailL;
        _company = companyOptions.Value;
        _settings = settings.Value;
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
            ModelState.AddModelError("Email", _L["Bu email adresi zaten kayıtlı"].Value);
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

                var culture = CultureInfo.CurrentUICulture;

                var template = System.IO.File.ReadAllText(
                    Path.Combine(Directory.GetCurrentDirectory(),
                    "EmailTemplates", "EmailConfirm.html"));

                var body = template
                    .Replace("{{Title}}", _emailL["EmailConfirmTitle"])
                    .Replace("{{Intro}}", _emailL["EmailConfirmIntro"])
                    .Replace("{{Button}}", _emailL["EmailConfirmButton"])
                    .Replace("{{Ignore}}", _emailL["EmailIgnoreText"])
                    .Replace("{{Footer}}", _emailL["EmailFooter"])
                    .Replace("{{Company}}", _company.Name)
                    .Replace("{{Link}}", confirmLink);

                await _emailService.SendAsync(
                    model.Email,
                    _emailL["EmailConfirmSubject"],
                    body
                );


           }
            catch (Exception ex)
            {
                // LOG AL ama kullanıcıyı bekletme
                //_logger.LogError(ex, "Email gönderilemedi");
                TempData["Error"] = ex.Message;
            }
        });


        TempData["Success"] = _L["Kayıt başarılı. Email adresinizi doğrulayın."].Value;
        return RedirectToAction("Login", "Account");
    }


    [HttpPost]
    public async Task<IActionResult> ResendConfirmationEmail(ResendConfirmationEmailViewModel model)
    {
 
        if (_userService.IsEmailExists(model.Email) == false)
        {
            string str = string.Format(_L["Email {0} bulunamadı"].Value, model.Email);
            TempData["Error"] = str;
            return RedirectToAction("Login", "Account");
        }

        var token = Guid.NewGuid().ToString("N");
        var EmailConfirmTokenExpire = DateTime.UtcNow.AddHours(24);


        _userService.ResendConfirmationEmail(model.Email, token, EmailConfirmTokenExpire);

        var confirmLink = Url.Action(
        "ConfirmEmail",
        "Account",
        new { token, email = model.Email },
        Request.Scheme
        );

        try
            {

                var culture = CultureInfo.CurrentUICulture;

                var template = System.IO.File.ReadAllText(
                    Path.Combine(Directory.GetCurrentDirectory(),
                    "EmailTemplates", "EmailConfirm.html"));

                var body = template
                    .Replace("{{Title}}", _emailL["EmailConfirmTitle"])
                    .Replace("{{Intro}}", _emailL["EmailConfirmIntro"])
                    .Replace("{{Button}}", _emailL["EmailConfirmButton"])
                    .Replace("{{Ignore}}", _emailL["EmailIgnoreText"])
                    .Replace("{{Footer}}", _emailL["EmailFooter"])
                    .Replace("{{Company}}", _company.Name)
                    .Replace("{{Link}}", confirmLink);

                await _emailService.SendAsync(
                    model.Email,
                    _emailL["EmailConfirmSubject"],
                    body
                );


            }
            catch (Exception ex)
            {
                // LOG AL ama kullanıcıyı bekletme
                //_logger.LogError(ex, "Email gönderilemedi");
                TempData["Error"] = ex.Message;
                return RedirectToAction("Login", "Account");
        }

        TempData["Success"] = string.Format(_L["Eğer email sistemde kayıtlıysa link gönderildi. {0}"].Value, model.Email);
        return RedirectToAction("Login", "Account");
    }


    [HttpPost]
    public async Task<IActionResult> ResendConfirmationEmail2()
    {

        var emailadres = HttpContext.Session.GetString("session_Email");

        if (string.IsNullOrEmpty(emailadres))
        {
            return RedirectToAction("Login", "Account");
        }

        var token = Guid.NewGuid().ToString("N");
        var EmailConfirmTokenExpire = DateTime.UtcNow.AddHours(24);


        _userService.ResendConfirmationEmail(emailadres, token, EmailConfirmTokenExpire);

        var confirmLink = Url.Action(
        "ConfirmEmail",
        "Account",
        new { token, email = emailadres },
        Request.Scheme
        );

        try
        {

            var culture = CultureInfo.CurrentUICulture;

            var template = System.IO.File.ReadAllText(
                Path.Combine(Directory.GetCurrentDirectory(),
                "EmailTemplates", "EmailConfirm.html"));

            var body = template
                .Replace("{{Title}}", _emailL["EmailConfirmTitle"])
                .Replace("{{Intro}}", _emailL["EmailConfirmIntro"])
                .Replace("{{Button}}", _emailL["EmailConfirmButton"])
                .Replace("{{Ignore}}", _emailL["EmailIgnoreText"])
                .Replace("{{Footer}}", _emailL["EmailFooter"])
                .Replace("{{Company}}", _company.Name)
                .Replace("{{Link}}", confirmLink);

            await _emailService.SendAsync(
                emailadres,
                _emailL["EmailConfirmSubject"],
                body
            );


        }
        catch (Exception ex)
        {
            // LOG AL ama kullanıcıyı bekletme
            //_logger.LogError(ex, "Email gönderilemedi");
            TempData["Error"] = ex.Message;
            return RedirectToAction("Profile", "Account");
        }

        TempData["Success"] = string.Format(_L["Eğer email sistemde kayıtlıysa link gönderildi. {0}"].Value, emailadres);
        return RedirectToAction("Profile", "Account");
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
    public async Task<IActionResult> TestEmail2(int id)
    {

        await _emailService.SendAsync("mehmetcangurel@gmail.com",
         _emailL["ResetPasswordSubject"],
         "Test email body " + id.ToString());

        return Content("OK");
    }

    [HttpGet]
    public async Task<IActionResult> TestEmail(int id)
    {

        string r = "";
        try
        {
        using var message = new MailMessage
        {
            From = new MailAddress(_settings.FromEmailAdress, _settings.FromName),
            Subject = "subject" + id.ToString(),
            Body = "htmlBody",
            IsBodyHtml = true
        };

        message.To.Add("mehmetcangurel@gmail.com");

        using var client = new SmtpClient(_settings.Host, _settings.Port)
        {
            Credentials = new NetworkCredential(
                _settings.UserName,
                _settings.Password
            ),
            EnableSsl = _settings.EnableSsl,
            Timeout = 10000 // ⬅️ 10 saniye timeout (çok önemli)
        };

      
            await client.SendMailAsync(message);
            r = "OK";
        }
        catch (Exception e)
        {

            r = e.ToString();
        }
    

        string result = r + "<br>_settings.Host" + _settings.Host + "<br>; _settings.Port" + _settings.Port + "<br>; _settings.EnableSsl" + _settings.EnableSsl;
        return Content(result);
    }

    [HttpGet]
    public IActionResult Profile()
    {
   

        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");



        var user = _userService.GetById(userId.Value);

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
        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");

        if (FormType == "Profile")
        {
            ModelState.Remove("Password");

            if (!ModelState.IsValid)
                return View(vm);

            _userService.Update(new UserDto
            {
                Id = userId.Value,
                FirstName = vm.Profile.FirstName,
                LastName = vm.Profile.LastName,
                PhoneNumber = vm.Profile.PhoneNumber,
                BirthDate = vm.Profile.BirthDate
            });

            TempData["Success"] = _L["Profil bilgileri güncellendi"].Value;
            return RedirectToAction("Profile");
        }

        if (FormType == "Password")
        {
            ModelState.Remove("Profile");

            if (!ModelState.IsValid)
                return View(vm);

            bool result = _userService.ChangePassword(
                userId.Value,
                vm.Password.CurrentPassword,
                vm.Password.NewPassword
            );

            if (!result)
            {
                ModelState.AddModelError(
                    "Password.CurrentPassword",
                    _L["Şu anki şifre hatalı"].Value    
                );

                var user = _userService.GetById(userId.Value);
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

            TempData["Success"] = _L["Şifre başarıyla değiştirildi"].Value;
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
    //[CheckSession("session_UserFullName")]
    public IActionResult Login(LoginViewModel vm)
    {

        if (!ModelState.IsValid)
            return View(vm);

        var user = _userService.ValidateUser(vm.UserName, vm.Password);

        if (user == null)
        {
            ModelState.AddModelError("kullanicisifrehatasi", _L["Kullanıcı adı veya şifre hatalı"].Value);
            return View(vm);
        }

        //if (!user.IsEmailConfirmed)
        //{
        //    ModelState.AddModelError("emaildogrulama", _L["Email adresinizi doğrulamanız gerekiyor"].Value);
        //    return View(vm);
        //}

        HttpContext.Session.SetInt32("session_UserId", user.Id);
        HttpContext.Session.SetString("session_UserFullName", user.FullName);
        HttpContext.Session.SetString("session_RoleName", user.RoleName);
        HttpContext.Session.SetString("session_Email", user.Email);
        HttpContext.Session.SetString("session_Avatar", user.Avatar);
        HttpContext.Session.SetString("session_IsEmailConfirmed", user.IsEmailConfirmed.ToString());



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
        try
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


        var templatePath = Path.Combine(
       Directory.GetCurrentDirectory(),
       "EmailTemplates",
       "ResetPassword.html"
   );

        var template = System.IO.File.ReadAllText(templatePath);

        var body = template
            .Replace("{{Title}}", _emailL["ResetPasswordTitle"])
            .Replace("{{Intro}}", _emailL["ResetPasswordIntro"])
            .Replace("{{Button}}", _emailL["ResetPasswordButton"])
            .Replace("{{Expire}}", _emailL["ResetPasswordExpire"])
            .Replace("{{Ignore}}", _emailL["ResetPasswordIgnore"])
            .Replace("{{Company}}", _company.Name)
            .Replace("{{Link}}", resetLink);

        _ = Task.Run(async () =>
        {
            try
            {
                await _emailService.SendAsync(
                    model.Email,
                    _emailL["ResetPasswordSubject"],
                    body
                );
            }
            catch
            {
                // log
            }
        });



        //_ = Task.Run(async () =>
        //{
        //    try
        //    {
        //        await _emailService.SendAsync(
        //            model.Email,
            //            _emailL["ResetPasswordSubject"],
            //            body
        //        );
        //    }
            //    catch
            //    {
            //        // log
            //    }
        //});

            await _emailService.SendAsync(
            model.Email,
            _emailL["ResetPasswordSubject"],
            body
            );



        return View("ForgotPasswordConfirmation");
    }
        catch (Exception ex)
        {
            return Content(ex.ToString()); // 🔥 gerçek hatayı gösterir
        }
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

    public IActionResult AccessDenied()
    {
        return View("AccessDenied", _L["Bu sayfayı görüntüleme yetkiniz yok."].Value);
    }

}
