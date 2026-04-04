using Microsoft.AspNetCore.Mvc;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.ViewModels;

public class UserAddressController : Controller
{
    private readonly IUserAddressService _service;

    public UserAddressController(IUserAddressService service)
    {
        _service = service;
    }

    public IActionResult Index()
    {

        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");


        var list = _service.GetByUserId(userId.Value);
        return View(list);
    }

    [HttpGet]
    public IActionResult Create(string returnUrl = null)
    {
        ViewBag.ReturnUrl = returnUrl;
        return View(new UserAddressViewModel());
    }


    [HttpPost]
    public IActionResult Create(UserAddressViewModel vm, string returnUrl)
    {
        if (!ModelState.IsValid)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View(vm);
        }

        var userId = HttpContext.Session.GetInt32("session_UserId");

        if (userId is null)
            return RedirectToAction("Index", "Home");

        _service.Insert(new SeramikStore.Entities.UserAddress
        {
            UserId = userId.Value,
            Ad = vm.Ad,
            Soyad = vm.Soyad,
            Telefon = vm.Telefon,
            Il = vm.Il,
            Ilce = vm.Ilce,
            Mahalle = vm.Mahalle,
            Adres = vm.Adres,
            Baslik = vm.Baslik,
            IsDefault = vm.IsDefault
        });

        // 🔐 Güvenlik: sadece local URL'e izin ver
        if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
        {
        return Redirect(returnUrl);
        }

        return RedirectToAction("Index", "UserAddress");
    }

    public IActionResult Delete(int id)
    {
        _service.Delete(id);
        return RedirectToAction("Index");
    }

    [HttpGet]
    public IActionResult Edit(int id, string returnUrl = null)
    {

        var userId = HttpContext.Session.GetInt32("session_UserId");
        if (userId is null)
            return RedirectToAction("Index", "Home");

        var address = _service.GetById(id);

        // Güvenlik: adres başka kullanıcıya ait mi?
        if (address == null || address.UserId != userId.Value)
            return RedirectToAction("Index");


        var vm = new UserAddressViewModel
        {
            Id = address.Id,
            Ad = address.Ad,
            Soyad = address.Soyad,
            Telefon = address.Telefon,
            Il = address.Il,
            Ilce = address.Ilce,
            Mahalle = address.Mahalle,
            Adres = address.Adres,
            Baslik = address.Baslik,
            IsDefault = address.IsDefault
        };

        ViewBag.ReturnUrl = returnUrl;

        return View(vm);
    }


    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Edit(UserAddressViewModel vm, string returnUrl)
    {
        if (!ModelState.IsValid)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View(vm);
        }

        var userId = HttpContext.Session.GetInt32("session_UserId");
        if (userId is null)
            return RedirectToAction("Index", "Home");

        _service.Update(new SeramikStore.Entities.UserAddress
        {
            Id = vm.Id,
            UserId = userId.Value,
            Ad = vm.Ad,
            Soyad = vm.Soyad,
            Telefon = vm.Telefon,
            Il = vm.Il,
            Ilce = vm.Ilce,
            Mahalle = vm.Mahalle,
            Adres = vm.Adres,
            Baslik = vm.Baslik,
            IsDefault = vm.IsDefault
        });


        // 🔐 Güvenlik: sadece local URL'e izin ver
        if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
        {
            return Redirect(returnUrl);
        }

        return RedirectToAction("Index");
    }

}
