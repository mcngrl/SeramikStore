using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SeramikStore.Entities;
using SeramikStore.Services;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;

public class ProductImageController : Controller
{
    private readonly IProductImageService _productImageService;
    private readonly IWebHostEnvironment _env;

    public ProductImageController(
        IProductImageService productImageService,
        IWebHostEnvironment env)
    {
        _productImageService = productImageService;
        _env = env;
    }

    // 📋 Ürüne ait resimler
    public IActionResult Index(int productId)
    {
        ViewBag.ProductId = productId;
        var images = _productImageService.GetByProductId(productId);
        return View(images);
    }

    // 📤 Upload
    //[HttpPost]
    //[ValidateAntiForgeryToken]
    //public IActionResult Upload(int productId, IFormFile image, bool isMain = false)
    //{
    //    if (image == null || image.Length == 0)
    //    {
    //        TempData["Error"] = "Lütfen bir resim seçiniz.";
    //        return RedirectToAction("Index", new { productId });
    //    }

    //    // uploads/products/{productId}
    //    var uploadFolder = Path.Combine(
    //        _env.WebRootPath,
    //        "uploads",
    //        "products",
    //        productId.ToString()
    //    );

    //    if (!Directory.Exists(uploadFolder))
    //        Directory.CreateDirectory(uploadFolder);

    //    var fileName = Guid.NewGuid() + Path.GetExtension(image.FileName);
    //    var filePath = Path.Combine(uploadFolder, fileName);

    //    using (var stream = new FileStream(filePath, FileMode.Create))
    //    {
    //        image.CopyTo(stream);
    //    }

    //    var imagePath = $"/uploads/products/{productId}/{fileName}";

    //    var productImage = new ProductImage
    //    {
    //        ProductId = productId,
    //        ImagePath = imagePath,
    //        IsMain = isMain,
    //        DisplayOrder = 0
    //    };

    //    _productImageService.Insert(productImage);

    //    if (isMain)
    //    {
    //        _productImageService.SetMainImage(productId, productImage.Id);
    //    }

    //    TempData["Success"] = "Resim başarıyla yüklendi.";
    //    return RedirectToAction("Index", new { productId });
    //}

    // ⭐ Ana resim yap
    [HttpPost]


    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Upload(int productId, IFormFile image, bool isMain = false)
    {
        if (image == null || image.Length == 0)
        {
            TempData["Error"] = "Lütfen bir resim seçiniz.";
            return RedirectToAction("Index", new { productId });
        }

        var uploadFolder = Path.Combine(
            _env.WebRootPath,
            "uploads",
            "products",
            productId.ToString()
        );

        if (!Directory.Exists(uploadFolder))
            Directory.CreateDirectory(uploadFolder);

        // Uzantı ne olursa olsun .webp olarak kaydet
        var fileName = Guid.NewGuid() + ".webp";
        var filePath = Path.Combine(uploadFolder, fileName);

        // ImageSharp ile WebP'ye çevir + EXIF yönünü düzelt
        using (var stream = image.OpenReadStream())
        using (var img = await SixLabors.ImageSharp.Image.LoadAsync(stream))
        {
            img.Mutate(x => x.AutoOrient());
            await img.SaveAsWebpAsync(filePath, new SixLabors.ImageSharp.Formats.Webp.WebpEncoder
            {
                Quality = 80
            });
        }

        var imagePath = $"/uploads/products/{productId}/{fileName}";

        var productImage = new ProductImage
        {
            ProductId = productId,
            ImagePath = imagePath,
            IsMain = isMain,
            DisplayOrder = 0
        };

        _productImageService.Insert(productImage);

        if (isMain)
            _productImageService.SetMainImage(productId, productImage.Id);

        TempData["Success"] = "Resim başarıyla yüklendi.";
        return RedirectToAction("Index", new { productId });
    }
    public IActionResult SetMain(int productId, int imageId)
    {
        _productImageService.SetMainImage(productId, imageId);
        return RedirectToAction("Index", new { productId });
    }

    // 🔢 Sıra güncelle
    [HttpPost]
    public IActionResult UpdateOrder(int id, int displayOrder, int productId)
    {
        var image = new ProductImage
        {
            Id = id,
            DisplayOrder = displayOrder
        };

        _productImageService.Update(image);
        return RedirectToAction("Index", new { productId });
    }

    // ❌ Sil
    [HttpPost]
    public IActionResult Delete(int id, int productId)
    {

        _productImageService.Delete(id);
        TempData["Success"] = "Resim silindi.";
        return RedirectToAction("Index", new { productId });
    }
}
