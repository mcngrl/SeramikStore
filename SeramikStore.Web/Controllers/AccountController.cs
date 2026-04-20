using Humanizer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;
using Microsoft.Extensions.Options;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages.Manage;
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

    #region Authentication
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


        var ConfirmCode = new Random().Next(100000, 999999).ToString();

        var user = new UserDto
        {
            FirstName = model.FirstName,
            LastName = model.LastName,
            Email = model.Email,
            PhoneNumber = model.PhoneNumber,
            BirthDate = model.BirthDate,
            IsActive = true,
            IsEmailConfirmed = false,
            EmailConfirmCode = ConfirmCode,
            EmailConfirmCodeExpire = DateTime.UtcNow.AddMinutes(10),
            EmailConfirmAttemptCount = 0,
            EmailConfirmLastSentAt = DateTime.UtcNow,
            RoleId = 2,
            AcceptKvkk = model.AcceptKvkk,
            AcceptMembershipAgreement = model.AcceptMembershipAgreement,
            AgreementAcceptedIp = HttpContext.Connection.RemoteIpAddress?.ToString()
        };

        _userService.Insert(user, model.Password);

        var confirmLink = Url.Action(
            "ConfirmEmail",
            "Account",
            new { ConfirmCode, email = model.Email },
            Request.Scheme
        );

        SendEmailForConfirm(model.Email, ConfirmCode);

        var new_user = _userService.GetByEmail(model.Email);
        SetSessionVariables(new_user);

        TempData["Success"] = _L["Kayıt başarılı. Email adresinizi doğrulayın."].Value;
        return RedirectToAction("VerifyEmail", "Account");


    }



    [HttpPost]
    public async Task<IActionResult> ResendConfEmail()
    {

        var emailaddress = HttpContext.Session.GetString("session_Email");

        if (string.IsNullOrEmpty(emailaddress))
        {
            return RedirectToAction("Login", "Account");
        }

         var user = _userService.GetByEmail(emailaddress);

        if (user == null)
        {
            TempData["Error"] = string.Format(_L["{0} Adresi ile kayıtlı kullanıcı bulunamadı."].Value, emailaddress);
            return View("VerifyEmail", new VerifyEmailViewModel { Email = emailaddress });
        }

        var now = DateTime.UtcNow;

        // 🔥  1 dakika kuralı
        if (user.EmailConfirmLastSentAt.HasValue &&
            user.EmailConfirmLastSentAt.Value.AddMinutes(1) > now)
        {
            TempData["Error"] = _L["Doğrulama kodu 1 dakika sonra tekrar gönderilebilir."].Value;
            return View("VerifyEmail", new VerifyEmailViewModel { Email = emailaddress });
        }


        // 🔥 2️ günlük limit (10 adet)
        if (user.EmailConfirmLastSentAt.HasValue &&
            user.EmailConfirmLastSentAt.Value.Date == now.Date &&
            user.EmailConfirmAttemptCount >= 10)
        {
            TempData["Error"] = _L["Bugün maksimum doğrulama isteğine ulaştınız. Yarın tekrar deneyiniz."].Value;
            return View("VerifyEmail", new VerifyEmailViewModel { Email = emailaddress });
        }

        // 🔥 3️ yeni günse count sıfırla
        int attemptCount = user.EmailConfirmAttemptCount;

        if (!user.EmailConfirmLastSentAt.HasValue ||
            user.EmailConfirmLastSentAt.Value.Date != now.Date)
        {
            attemptCount = 0;
        }

        attemptCount++;

        var ConfirmCode = new Random().Next(100000, 999999).ToString();
        var EmailConfirmCodeExpire = DateTime.UtcNow.AddMinutes(10);



        _userService.ResendConfirmationEmail(emailaddress, ConfirmCode, EmailConfirmCodeExpire, attemptCount, DateTime.UtcNow);

        var confirmLink = Url.Action(
        "ConfirmEmail",
        "Account",
        new { ConfirmCode, email = emailaddress },
        Request.Scheme
        );

        //System.Diagnostics.Debug.WriteLine(confirmLink);

        SendEmailForConfirm(emailaddress, ConfirmCode);
 

        TempData["Success"] = string.Format(_L["Email adresinize gönderilen bağlantıya tıklayarak doğrulama yapınız. {0}"].Value, emailaddress);
        return RedirectToAction("VerifyEmail", "Account");
    }

    [HttpGet]
    public IActionResult ConfirmEmailStart()
    {
        return View();
    }

    [HttpGet]
    public IActionResult VerifyEmail()
    {
        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");

        var model = new VerifyEmailViewModel
        {
            Email = HttpContext.Session.GetString("session_Email")
        };

        return View(model);
    }

    [HttpPost]
    public IActionResult VerifyEmail(VerifyEmailViewModel model)
    {
        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId == null)
            return RedirectToAction("Login");


        if (model.Email == null)
        {
            return RedirectToAction("Login");
        }

        var user = _userService.GetByEmail(model.Email);

        if (user == null)
        {
            TempData["Error"] = string.Format(_L["Email adresinize gönderilen bağlantıya tıklayarak doğrulama yapınız. {0}"].Value, model.Email);
            return View("VerifyEmail", new VerifyEmailViewModel { Email = model.Email , Code = model.Code });
        }
        if (user.Id != (int)userId)
        {
            TempData["Error"] = _L["E-Posta ile giriş yapan kullanıcı uyuşmuyor. {0}"].Value.ToString().FormatWith(model.Email);
            return View("VerifyEmail", new VerifyEmailViewModel { Email = model.Email, Code = model.Code });
        }
        if (user.IsEmailConfirmed)
        {
            TempData["Error"] = _L["Email zaten doğrulanmış"].Value;
            return View("VerifyEmail", new VerifyEmailViewModel { Email = model.Email, Code = model.Code });
        }

        if (user.EmailConfirmCode != model.Code)
        {
            TempData["Error"] = _L["Geçersiz doğrulama linki"].Value;
            return View("VerifyEmail", new VerifyEmailViewModel { Email = model.Email, Code = model.Code });
        }


        if (user.EmailConfirmCodeExpire < DateTime.UtcNow)
        {
            TempData["Error"] = _L["Doğrulama linkinin süresi dolmuş"].Value;
            return View("VerifyEmail", new VerifyEmailViewModel { Email = model.Email, Code = model.Code });
        }


        _userService.ConfirmEmail(user.Id);

        var updated_user = _userService.GetById(user.Id);
        SetSessionVariables(updated_user);

        TempData["Success"] = _L["Email başarıyla doğrulandı"].Value;
        return RedirectToAction("Profile", "Account");
    }


    [HttpGet]
    public IActionResult ConfirmEmail(string email, string ConfirmCode)
    {
        if (email == null)
        {
            return RedirectToAction("Login");
        }

        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");

        var user = _userService.GetByEmail(email);

        if (user == null)
            return View("EmailConfirmResult", _L["Kullanıcı bulunamadı"].Value);

        if (user.Id != (int)userId)
            return View("EmailConfirmResult", _L["E-Posta ile giriş yapan kullanıcı uyuşmuyor. {0}"].Value.ToString().FormatWith(email));

        if (user.IsEmailConfirmed)
            return View("EmailConfirmResult", _L["Email zaten doğrulanmış"].Value);

        if (user.EmailConfirmCode != ConfirmCode)
            return View("EmailConfirmResult", _L["Geçersiz doğrulama linki"].Value);

        if (user.EmailConfirmCodeExpire < DateTime.UtcNow)
            return View("EmailConfirmResult", _L["Doğrulama linkinin süresi dolmuş"].Value);

        _userService.ConfirmEmail(user.Id);

        return View("EmailConfirmResult", _L["Email başarıyla doğrulandı"].Value);
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

            UserDto TheUser = new UserDto
            {
                Id = userId.Value,
                FirstName = vm.Profile.FirstName,
                LastName = vm.Profile.LastName,
                PhoneNumber = vm.Profile.PhoneNumber,
                BirthDate = vm.Profile.BirthDate,
                Email = vm.Profile.Email
            };


            var result = _userService.Update(TheUser);

            var user = _userService.GetById(userId.Value);

            SetSessionVariables(user);

            if (result.Result == 1 || result.Result == 2)
            {
                TempData["Success"] = result.Message.ToString();
            }
            else
            {
                TempData["Error"] = result.Message.ToString().FormatWith(TheUser.Email);
            }

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

    private void SetSessionVariables(UserDto user)
    {
        HttpContext.Session.SetInt32("session_UserId", user.Id);
        HttpContext.Session.SetString("session_UserFullName", user.FullName);
        HttpContext.Session.SetString("session_Email", user.Email);
        HttpContext.Session.SetString("session_Avatar", user.Avatar);
        HttpContext.Session.SetString("session_IsEmailConfirmed", user.IsEmailConfirmed.ToString());
        HttpContext.Session.SetString("session_RoleName", user.RoleName);
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
        HttpContext.Session.SetString("session_Email", user.Email);
        HttpContext.Session.SetString("session_Avatar", user.Avatar);
        HttpContext.Session.SetString("session_IsEmailConfirmed", user.IsEmailConfirmed.ToString());
        HttpContext.Session.SetString("session_RoleName", user.RoleName);



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


    public async Task<IActionResult> ForgotPassword(ForgotPasswordViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        var user = _userService.GetByEmail(model.Email);

        // security: user yoksa bile aynı ekran
        if (user == null)
            return View("ForgotPasswordConfirmation");

        var token = Guid.NewGuid().ToString("N");

        _userService.SetResetPasswordToken(
            user.Id,
            token,
            DateTime.UtcNow.AddHours(1)
        );

        var resetLink = Url.Action(
            "ResetPassword",
            "Account",
             new { email = model.Email, token },
            Request.Scheme
        );

        SendEmailForResetPassword(model.Email, resetLink);
        //await SendEmail2(model.Email, resetLink);
        //SendEmail3(model.Email, resetLink);

 

        TempData["Success"] = _L["Şifre sıfırlama bağlantısı gönderilmiştir."].Value;

        return RedirectToAction("Index", "Home");
    }


    [HttpPost]
    public async Task<IActionResult> ForgotPasswordOLD(ForgotPasswordViewModel model)
    {
        try
        {
        if (!ModelState.IsValid)
            return View(model);

        var user = _userService.GetByEmail(model.Email);
        if (user == null)
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
            .Replace("{{logo}}", _company.LogoUrl)
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
                    _emailL["ResetPasswordSubject"].Value,
                    body
                );
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            }
        });





            //await _emailService.SendAsync(
            //model.Email,
            //_emailL["ResetPasswordSubject"],
            //body
            //);

        TempData["Success"] = _L["Şifre sıfırlama bağlantısı gönderilmiştir"].Value;
        return RedirectToAction("Index", "Home");

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

        var user_withpass = _userService.GetById(user.Id);
        SetSessionVariables(user_withpass);

        TempData["Success"] = _L["Şifreniz başarıyla güncellenmiştir"].Value;
        return RedirectToAction("Index", "Home");
    }

    public IActionResult AccessDenied()
    {
        return View("AccessDenied", _L["Bu sayfayı görüntüleme yetkiniz yok."].Value);
    }
    #endregion


    #region EmailMethods
    void SendEmailForConfirm(string emailaddress, string ConfirmCode)
    {
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
                    .Replace("{{Info}}", _emailL["EmailConfirmInfo"])
                    .Replace("{{logo}}", _company.LogoUrl)
                    .Replace("{{Button}}", _emailL["{0}"].Value.ToString().FormatWith(ConfirmCode))
                    .Replace("{{Ignore}}", _emailL["EmailIgnoreText"])
                    .Replace("{{Footer}}", _emailL["EmailFooter"])
                    .Replace("{{Company}}", _company.Name)
                    .Replace("{{Code}}", ConfirmCode);

                await _emailService.SendAsync(
                    emailaddress,
                    _emailL["EmailConfirmSubject"].Value.ToString().FormatWith(ConfirmCode),
                    body);


            }
            catch (Exception ex)
            {
                // LOG AL ama kullanıcıyı bekletme
                //_logger.LogError(ex, "Email gönderilemedi");
                TempData["Error"] = ex.Message;
            }
        });
    }


    private void SendEmailForResetPassword(string emailaddress, string resetLink)
    {
        _ = Task.Run(async () =>
        {
            try
            {

                var culture = CultureInfo.CurrentUICulture;

                var template = System.IO.File.ReadAllText(
                Path.Combine(Directory.GetCurrentDirectory(),
                        "EmailTemplates", "PwdReset.html"));

                var body = template 
                    .Replace("{{Intro}}", _emailL["ResetPasswordIntro"])
                    .Replace("{{Info}}", _emailL["ResetPasswordInfo"])
                    .Replace("{{logo}}", _company.LogoUrl)
                    .Replace("{{Company}}", _company.Name)
                    .Replace("{{LINKTEXT}}", _emailL["ResetPasswordLinkText"])
                    .Replace("{{Code}}", resetLink);

                await _emailService.SendAsync(
                    emailaddress,
                    _emailL["ResetPasswordSubject"].Value.ToString(),
                    body);
            }
            catch (Exception ex)
            {
                // LOG AL ama kullanıcıyı bekletme
                //_logger.LogError(ex, "Email gönderilemedi");
                TempData["Error"] = ex.Message;
            }
        });
    }
    public IActionResult Temp()
    {
        return View();
    }
    public IActionResult FormTemp()
    {
        return View();
    }

    #endregion
}
