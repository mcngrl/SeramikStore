using Microsoft.AspNetCore.Mvc;
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
        int userId = HttpContext.Session.GetInt32("userId").Value;
        var list = _service.GetByUserId(userId);
        return View(list);
    }

    [HttpGet]
    public IActionResult Create()
    {
        return View(new UserAddressViewModel());
    }

    [HttpPost]
    public IActionResult Create(UserAddressViewModel vm)
    {
        if (!ModelState.IsValid) return View(vm);

        _service.Insert(new SeramikStore.Entities.UserAddress
        {
            UserId = HttpContext.Session.GetInt32("userId").Value,
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

        return RedirectToAction("Index");
    }

    public IActionResult Delete(int id)
    {
        _service.Delete(id);
        return RedirectToAction("Index");
    }

    [HttpGet]
    public IActionResult Edit(int id)
    {
        int userId = HttpContext.Session.GetInt32("userId").Value;

        var address = _service.GetById(id);

        // Güvenlik: adres başka kullanıcıya ait mi?
        if (address == null || address.UserId != userId)
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

        return View(vm);
    }


    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Edit(UserAddressViewModel vm)
    {
        if (!ModelState.IsValid)
            return View(vm);

        int userId = HttpContext.Session.GetInt32("userId").Value;

        _service.Update(new SeramikStore.Entities.UserAddress
        {
            Id = vm.Id,
            UserId = userId,
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

        return RedirectToAction("Index");
    }

}
