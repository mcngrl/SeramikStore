
using SkiaSharp;

class Program
{
    static async Task Main(string[] args)
    {
        Console.WriteLine("=== JPG/PNG → WebP Dönüştürücü ===\n");

        // Klasör yolu argümandan veya elle girilebilir
        string folderPath;

        if (args.Length > 0 && Directory.Exists(args[0]))
        {
            folderPath = args[0];
        }
        else
        {
            Console.Write("Klasör yolunu girin: ");
            folderPath = Console.ReadLine()?.Trim() ?? "";
        }

        if (string.IsNullOrWhiteSpace(folderPath) ||
            !Directory.Exists(folderPath))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Geçersiz klasör yolu.");
            Console.ResetColor();
            return;
        }

        // Kalite ayarı
        Console.Write("WebP kalitesi (1-100, varsayılan 80): ");
        var qualityInput = Console.ReadLine()?.Trim();

        int quality = int.TryParse(qualityInput, out var q) &&
                      q >= 1 && q <= 100 ? q : 80;

        // Orijinal dosyalar silinsin mi?
        Console.Write("Dönüştürme sonrası orijinal dosyalar silinsin mi? (e/h, varsayılan h): ");
        var deleteInput = Console.ReadLine()?.Trim().ToLower();

        bool deleteOriginals =
            deleteInput == "e" || deleteInput == "evet";

        // Alt klasörler dahil edilsin mi?
        Console.Write("Alt klasörler de dahil edilsin mi? (e/h, varsayılan e): ");
        var subDirInput = Console.ReadLine()?.Trim().ToLower();

        bool includeSubDirs =
            subDirInput != "h" && subDirInput != "hayır";

        var searchOption = includeSubDirs
            ? SearchOption.AllDirectories
            : SearchOption.TopDirectoryOnly;

        var extensions = new[] { "*.jpg", "*.jpeg", "*.png" };

        var files = extensions
            .SelectMany(ext => Directory.GetFiles(
                folderPath, ext, searchOption))
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToList();

        if (files.Count == 0)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("\nBu klasörde dönüştürülecek JPG/PNG dosyası bulunamadı.");
            Console.ResetColor();
            return;
        }

        Console.WriteLine($"\n{files.Count} dosya bulundu. Dönüştürme başlıyor...\n");

        int success = 0;
        int failed = 0;
        int skipped = 0;
        long totalSavedBytes = 0;

        foreach (var filePath in files)
        {
            var outputPath = Path.ChangeExtension(filePath, ".webp");

            // WebP dosyası zaten varsa atla
            if (File.Exists(outputPath))
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine($"[ATLA]  {Path.GetFileName(filePath)} → zaten mevcut");
                Console.ResetColor();

                skipped++;
                continue;
            }

            try
            {
                var originalSize = new FileInfo(filePath).Length;

                // Dosyayı belleğe al
                using var stream = File.OpenRead(filePath);
                using var codec = SKCodec.Create(stream);

                if (codec == null)
                    throw new Exception("Görüntü dosyası okunamadı.");

                // Görüntüyü decode et
                using var bitmap = SKBitmap.Decode(codec);

                if (bitmap == null)
                    throw new Exception("Görüntü çözümlenemedi.");

                // EXIF yönünü düzelt
                using var orientedBitmap = ApplyOrientation(
                    bitmap, codec.EncodedOrigin);

                // WebP olarak encode et
                using var image = SKImage.FromBitmap(orientedBitmap);

                using var encodedData = image.Encode(
                    SKEncodedImageFormat.Webp,
                    quality);

                if (encodedData == null)
                    throw new Exception("WebP dönüştürme başarısız.");

                using (var outputStream = File.Create(outputPath))
                {
                    encodedData.SaveTo(outputStream);
                }

                var newSize = new FileInfo(outputPath).Length;

                var savedBytes = originalSize - newSize;
                var savedPercent = originalSize > 0
                    ? (double)savedBytes / originalSize * 100
                    : 0;

                totalSavedBytes += savedBytes;

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(
                    $"[OK]    {Path.GetFileName(filePath)} " +
                    $"({FormatBytes(originalSize)} → {FormatBytes(newSize)}, " +
                    $"%{savedPercent:F1} küçüldü)");

                Console.ResetColor();

                if (deleteOriginals)
                    File.Delete(filePath);

                success++;
            }
            catch (Exception ex)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(
                    $"[HATA]  {Path.GetFileName(filePath)} → {ex.Message}");

                Console.ResetColor();

                failed++;
            }
        }

        // Özet
        Console.WriteLine("\n" + new string('─', 50));
        Console.WriteLine("Tamamlandı!");
        Console.WriteLine($"  ✔ Başarılı : {success}");
        Console.WriteLine($"  ✘ Hatalı   : {failed}");
        Console.WriteLine($"  ↷ Atlanan  : {skipped}");
        Console.WriteLine($"  💾 Kazanılan alan: {FormatBytes(totalSavedBytes)}");
        Console.WriteLine(new string('─', 50));
    }

    // EXIF fotoğraf yönünü düzeltir
    static SKBitmap ApplyOrientation(
        SKBitmap source,
        SKEncodedOrigin origin)
    {
        if (origin == SKEncodedOrigin.TopLeft)
            return source.Copy();

        bool swapDimensions =
            origin == SKEncodedOrigin.LeftTop ||
            origin == SKEncodedOrigin.RightTop ||
            origin == SKEncodedOrigin.RightBottom ||
            origin == SKEncodedOrigin.LeftBottom;

        int width = swapDimensions ? source.Height : source.Width;
        int height = swapDimensions ? source.Width : source.Height;

        var result = new SKBitmap(width, height);

        using var canvas = new SKCanvas(result);

        canvas.Clear(SKColors.Transparent);

        switch (origin)
        {
            case SKEncodedOrigin.TopRight:
                canvas.Translate(width, 0);
                canvas.Scale(-1, 1);
                break;

            case SKEncodedOrigin.BottomRight:
                canvas.Translate(width, height);
                canvas.RotateDegrees(180);
                break;

            case SKEncodedOrigin.BottomLeft:
                canvas.Translate(0, height);
                canvas.Scale(1, -1);
                break;

            case SKEncodedOrigin.LeftTop:
                canvas.RotateDegrees(90);
                canvas.Scale(1, -1);
                break;

            case SKEncodedOrigin.RightTop:
                canvas.Translate(width, 0);
                canvas.RotateDegrees(90);
                break;

            case SKEncodedOrigin.RightBottom:
                canvas.Translate(0, height);
                canvas.RotateDegrees(-90);
                break;

            case SKEncodedOrigin.LeftBottom:
                canvas.Translate(0, height);
                canvas.RotateDegrees(-90);
                canvas.Scale(1, -1);
                break;
        }

        canvas.DrawBitmap(
            source,
            new SKRect(0, 0, source.Width, source.Height),
            new SKRect(0, 0, source.Width, source.Height),
            new SKPaint
            {
                IsAntialias = true
            });

        canvas.Flush();

        return result;
    }

    static string FormatBytes(long bytes)
    {
        if (bytes < 1024)
            return $"{bytes} B";

        if (bytes < 1024 * 1024)
            return $"{bytes / 1024.0:F1} KB";

        return $"{bytes / (1024.0 * 1024):F1} MB";
    }
}
