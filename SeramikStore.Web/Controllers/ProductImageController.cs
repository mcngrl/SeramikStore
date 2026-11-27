
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using SeramikStore.Entities;
using SeramikStore.Services;
using SeramikStore.Web.Options;
using SkiaSharp;

public class ProductImageController : Controller
{
    private readonly IProductImageService _productImageService;
    private readonly IWebHostEnvironment _env;
    private readonly CompanyOptions _company;

    public ProductImageController(
        IProductImageService productImageService,
        IWebHostEnvironment env,
        IOptions<CompanyOptions> companyOptions)
    {
        _productImageService = productImageService;
        _env = env;
        _company = companyOptions.Value;
    }

    // Ürüne ait resimler
    public IActionResult Index(int productId)
    {
        ViewBag.ProductId = productId;

        var images = _productImageService.GetByProductId(productId);

        return View(images);
    }

    // Resim yükleme
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Upload(
        int productId,
        List<IFormFile> images,
        bool isMain = false)
    {
        if (images == null || images.Count == 0)
        {
            TempData["Error"] = "Lütfen en az bir resim seçiniz.";
            return RedirectToAction("Index", new { productId });
        }

        var uploadFolder = Path.Combine(
            _env.WebRootPath,
            "uploads",
            "products"
        );

        Directory.CreateDirectory(uploadFolder);

        bool firstImage = true;
        int uploadedCount = 0;

        foreach (var image in images)
        {
            if (image == null || image.Length == 0)
                continue;

            var baseName = Guid.NewGuid().ToString("N");

            var fullFileName = baseName + ".webp";
            var mediumFileName = baseName + "_medium.webp";
            var thumbFileName = baseName + "_thumb.webp";

            var fullPath = Path.Combine(uploadFolder, fullFileName);
            var mediumPath = Path.Combine(uploadFolder, mediumFileName);
            var thumbPath = Path.Combine(uploadFolder, thumbFileName);

            using var stream = image.OpenReadStream();
            using var originalBitmap = LoadOrientedBitmap(stream);

            // Ana fotoğraf: Maksimum 1200px genişlik
            SaveWebp(
                originalBitmap,
                fullPath,
                1200,
                0,
                82,
                false
            );

            // Orta fotoğraf: 450x560 sınırları içerisinde
            SaveWebp(
                originalBitmap,
                mediumPath,
                450,
                560,
                75,
                false
            );

            // Thumbnail: 200x200 kırpılmış
            SaveWebp(
                originalBitmap,
                thumbPath,
                200,
                200,
                70,
                true
            );

            var productImage = new ProductImage
            {
                ProductId = productId,
                ImagePath = $"/uploads/products/{fullFileName}",
                IsMain = isMain && firstImage,
                DisplayOrder = 0
            };

            _productImageService.Insert(productImage);

            if (isMain && firstImage)
            {
                _productImageService.SetMainImage(
                    productId,
                    productImage.Id
                );
            }

            firstImage = false;
            uploadedCount++;
        }

        TempData["Success"] =
            $"{uploadedCount} resim başarıyla yüklendi.";

        return RedirectToAction("Index", new { productId });
    }

    // EXIF yön bilgisini düzelt
    private static SKBitmap LoadOrientedBitmap(Stream stream)
    {
        using var memory = new MemoryStream();
        stream.CopyTo(memory);

        using var data = SKData.CreateCopy(memory.ToArray());
        using var codec = SKCodec.Create(data);

        var bitmap = SKBitmap.Decode(data);

        if (bitmap == null)
            throw new InvalidOperationException("Görsel okunamadı.");

        if (codec == null)
            return bitmap;

        var origin = codec.EncodedOrigin;

        if (origin == SKEncodedOrigin.TopLeft)
            return bitmap;

        int width = bitmap.Width;
        int height = bitmap.Height;

        bool swapDimensions =
            origin == SKEncodedOrigin.LeftTop ||
            origin == SKEncodedOrigin.RightTop ||
            origin == SKEncodedOrigin.RightBottom ||
            origin == SKEncodedOrigin.LeftBottom;

        int outputWidth = swapDimensions ? height : width;
        int outputHeight = swapDimensions ? width : height;

        var orientedBitmap = new SKBitmap(
            new SKImageInfo(outputWidth, outputHeight)
        );

        using (var canvas = new SKCanvas(orientedBitmap))
        {
            var matrix = new SKMatrix
            {
                ScaleX = 1,
                ScaleY = 1,
                SkewX = 0,
                SkewY = 0,
                TransX = 0,
                TransY = 0,
                Persp0 = 0,
                Persp1 = 0,
                Persp2 = 1
            };

            switch (origin)
            {
                case SKEncodedOrigin.TopRight:
                    matrix.ScaleX = -1;
                    matrix.TransX = width;
                    break;

                case SKEncodedOrigin.BottomRight:
                    matrix.ScaleX = -1;
                    matrix.TransX = width;
                    matrix.ScaleY = -1;
                    matrix.TransY = height;
                    break;

                case SKEncodedOrigin.BottomLeft:
                    matrix.ScaleY = -1;
                    matrix.TransY = height;
                    break;

                case SKEncodedOrigin.LeftTop:
                    matrix.ScaleX = 0;
                    matrix.SkewX = 1;
                    matrix.SkewY = 1;
                    matrix.ScaleY = 0;
                    break;

                case SKEncodedOrigin.RightTop:
                    matrix.ScaleX = 0;
                    matrix.SkewX = -1;
                    matrix.TransX = height;
                    matrix.SkewY = 1;
                    matrix.ScaleY = 0;
                    break;

                case SKEncodedOrigin.RightBottom:
                    matrix.ScaleX = 0;
                    matrix.SkewX = -1;
                    matrix.TransX = height;
                    matrix.SkewY = -1;
                    matrix.ScaleY = 0;
                    matrix.TransY = width;
                    break;

                case SKEncodedOrigin.LeftBottom:
                    matrix.ScaleX = 0;
                    matrix.SkewX = 1;
                    matrix.SkewY = -1;
                    matrix.ScaleY = 0;
                    matrix.TransY = width;
                    break;
            }

            canvas.SetMatrix(matrix);
            canvas.DrawBitmap(bitmap, 0, 0);
            canvas.Flush();
        }

        bitmap.Dispose();

        return orientedBitmap;
    }

    // WebP dönüştürme ve kaydetme
    private static void SaveWebp(
        SKBitmap source,
        string filePath,
        int targetWidth,
        int targetHeight,
        int quality,
        bool cropToFill)
    {
        int outputWidth;
        int outputHeight;

        SKRect sourceRect;
        SKRect destinationRect;

        if (cropToFill)
        {
            outputWidth = targetWidth;
            outputHeight = targetHeight;

            float sourceRatio =
                (float)source.Width / source.Height;

            float targetRatio =
                (float)targetWidth / targetHeight;

            if (sourceRatio > targetRatio)
            {
                float cropWidth = source.Height * targetRatio;
                float left = (source.Width - cropWidth) / 2f;

                sourceRect = new SKRect(
                    left, 0,
                    left + cropWidth,
                    source.Height
                );
            }
            else
            {
                float cropHeight = source.Width / targetRatio;
                float top = (source.Height - cropHeight) / 2f;

                sourceRect = new SKRect(
                    0, top,
                    source.Width,
                    top + cropHeight
                );
            }

            destinationRect = new SKRect(
                0, 0, outputWidth, outputHeight
            );
        }
        else
        {
            float scale = targetHeight <= 0
                ? (float)targetWidth / source.Width
                : Math.Min(
                    (float)targetWidth / source.Width,
                    (float)targetHeight / source.Height
                );

            scale = Math.Min(1f, scale);

            outputWidth = Math.Max(
                1, (int)Math.Round(source.Width * scale)
            );

            outputHeight = Math.Max(
                1, (int)Math.Round(source.Height * scale)
            );

            sourceRect = new SKRect(
                0, 0, source.Width, source.Height
            );

            destinationRect = new SKRect(
                0, 0, outputWidth, outputHeight
            );
        }

        var info = new SKImageInfo(outputWidth, outputHeight);

        using var surface = SKSurface.Create(info);

        surface.Canvas.Clear(SKColors.Transparent);

        surface.Canvas.DrawBitmap(
            source,
            sourceRect,
            destinationRect,
            new SKSamplingOptions(
                SKFilterMode.Linear,
                SKMipmapMode.Linear
            )
        );

        using var result = surface.Snapshot();

        using var encoded = result.Encode(
            SKEncodedImageFormat.Webp,
            quality
        );

        if (encoded == null)
            throw new InvalidOperationException(
                "WebP dönüştürme başarısız."
            );

        using var output = System.IO.File.Create(filePath);

        encoded.SaveTo(output);
    }

    // Ana resim belirleme
    public IActionResult SetMain(int productId, int imageId)
    {
        _productImageService.SetMainImage(productId, imageId);

        return RedirectToAction("Index", new { productId });
    }

    // Sıra güncelle
    [HttpPost]
    public IActionResult UpdateOrder(
        int id,
        int displayOrder,
        int productId)
    {
        var image = new ProductImage
        {
            Id = id,
            DisplayOrder = displayOrder
        };

        _productImageService.Update(image);

        return RedirectToAction("Index", new { productId });
    }

    // Tek resim silme
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Delete(int id, int productId)
    {
        var image = _productImageService.GetById(id);

        if (image != null)
        {
            DeleteImageFiles(image.ImagePath);
            _productImageService.Delete(id);
        }

        TempData["Success"] = "Resim silindi.";

        return RedirectToAction("Index", new { productId });
    }

    // Çoklu resim silme
    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult DeleteMultiple(
        List<int> imageIds,
        int productId)
    {
        if (imageIds == null || !imageIds.Any())
        {
            TempData["Error"] =
                "Lütfen en az bir resim seçiniz.";

            return RedirectToAction("Index", new { productId });
        }

        int deletedCount = 0;

        foreach (var id in imageIds)
        {
            var image = _productImageService.GetById(id);

            if (image == null)
                continue;

            DeleteImageFiles(image.ImagePath);
            _productImageService.Delete(id);

            deletedCount++;
        }

        TempData["Success"] =
            $"{deletedCount} resim silindi.";

        return RedirectToAction("Index", new { productId });
    }

    // Ana, medium ve thumbnail dosyalarını sil
    private void DeleteImageFiles(string imagePath)
    {
        var fileName = Path.GetFileName(imagePath);

        var uploadFolder = Path.Combine(
            _env.WebRootPath,
            "uploads",
            "products"
        );

        var baseName = Path.GetFileNameWithoutExtension(fileName);

        var files = new[]
        {
            Path.Combine(uploadFolder, baseName + ".webp"),
            Path.Combine(uploadFolder, baseName + "_medium.webp"),
            Path.Combine(uploadFolder, baseName + "_thumb.webp")
        };

        foreach (var file in files)
        {
            if (System.IO.File.Exists(file))
                System.IO.File.Delete(file);
        }
    }
}
