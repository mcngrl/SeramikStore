using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;

namespace SeramikStore.Web.Controllers
{
    public class Culture : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Set(string culture, string returnUrl)
        {
            Response.Cookies.Append(
                CookieRequestCultureProvider.DefaultCookieName,
                CookieRequestCultureProvider.MakeCookieValue(
                    new RequestCulture(culture)
                ), 
                new CookieOptions
                {
                    Expires = DateTimeOffset.UtcNow.AddYears(1)
                }
            );
            return LocalRedirect(returnUrl);
        }

    }
}
