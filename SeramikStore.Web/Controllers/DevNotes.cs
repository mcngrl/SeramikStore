#if DEBUG
using Microsoft.AspNetCore.Mvc;

public class DevNotesController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}
#endif
