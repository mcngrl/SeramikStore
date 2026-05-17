using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using SeramikStore.Contracts.Admin;
using SeramikStore.Services;
using SeramikStore.Services.Email;
using System.Data;

namespace SeramikStore.Web.Controllers
{
    public class AdminController : Controller
    {

        private readonly IAppLogService _appLogService;
        private readonly INotificationService _notificationService;
        private readonly IEmailService _emailService;

        public AdminController(IAppLogService appLogService, INotificationService notificationService, IEmailService emailService)
        {
            _appLogService = appLogService;
            _notificationService = notificationService;
            _emailService = emailService;
        }

        [HttpGet]
        public IActionResult Index()
        {
            var role = HttpContext.Session.GetString("session_RoleName");
            if (role != "Admin")
                return RedirectToAction("Index", "Home");

            //return View("~/Views/Admin/Index.cshtml");
            //return View("Index");
            return View();
        }

        public IActionResult AppLogs(string level = null)
        {
            var role = HttpContext.Session.GetString("session_RoleName");
            if (role != "Admin")
                return RedirectToAction("Index", "Home");

            var logs = _appLogService.GetRecent(200);

            if (!string.IsNullOrEmpty(level))
                logs = logs.Where(x => x.LogLevel == level).ToList();

            return View(logs);
        }

        [HttpPost]
        public async Task<IActionResult> TestNotification()
        {
            var role = HttpContext.Session.GetString("session_RoleName");
            if (role != "Admin")
                return Json(new { success = false, message = "Yetkisiz erişim." });

            try
            {
                await _notificationService.SendToAdmin(
                    "🔔 Test Bildirimi",
                    $"Bu bir test bildirimidir. Tarih: {DateTime.Now:dd.MM.yyyy HH:mm:ss}"
                );
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> TestEmail()
        {
            var role = HttpContext.Session.GetString("session_RoleName");
            if (role != "Admin")
                return Json(new { success = false, message = "Yetkisiz erişim." });

            var email = HttpContext.Session.GetString("session_Email");
            if (string.IsNullOrEmpty(email))
                return Json(new { success = false, message = "Session'da email bulunamadı." });

            try
            {
                await _emailService.SendAsync(
                    email,
                    "Test Email  ",
                    $@"<h3>Test Email</h3>
               <p>Bu bir test emailidir.</p>
               <p>Tarih: {DateTime.Now:dd.MM.yyyy HH:mm:ss}</p>
               <p>Gönderen: Admin Panel</p>"
                );
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
    }
}


