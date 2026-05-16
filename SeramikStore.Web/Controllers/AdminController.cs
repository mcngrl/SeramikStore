using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.Controllers
{
    public class AdminController : Controller
    {
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
    }
}


