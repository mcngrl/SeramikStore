using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Webp;
using SixLabors.ImageSharp.Processing;
using static System.Net.Mime.MediaTypeNames;

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
            folderPath = Console.ReadLine()?.Trim();
        }

        if (string.IsNullOrEmpty(folderPath) || !Directory.Exists(folderPath))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Geçersiz klasör yolu.");
            Console.ResetColor();
            return;
        }

        // Kalite ayarı
        Console.Write("WebP kalitesi (1-100, varsayılan 80): ");
        var qualityInput = Console.ReadLine()?.Trim();
        int quality = int.TryParse(qualityInput, out var q) && q >= 1 && q <= 100 ? q : 80;

        // Orijinal dosyalar silinsin mi?
        Console.Write("Dönüştürme sonrası orijinal dosyalar silinsin mi? (e/h, varsayılan h): ");
        var deleteInput = Console.ReadLine()?.Trim().ToLower();
        bool deleteOriginals = deleteInput == "e" || deleteInput == "evet";

        // Alt klasörler dahil edilsin mi?
        Console.Write("Alt klasörler de dahil edilsin mi? (e/h, varsayılan e): ");
        var subDirInput = Console.ReadLine()?.Trim().ToLower();
        bool includeSubDirs = subDirInput != "h" && subDirInput != "hayır";

        var searchOption = includeSubDirs ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly;
        var extensions = new[] { "*.jpg", "*.jpeg", "*.png" };

        var files = extensions
            .SelectMany(ext => Directory.GetFiles(folderPath, ext, searchOption))
            .ToList();

        if (files.Count == 0)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("\nBu klasörde dönüştürülecek JPG/PNG dosyası bulunamadı.");
            Console.ResetColor();
            return;
        }

        Console.WriteLine($"\n{files.Count} dosya bulundu. Dönüştürme başlıyor...\n");

        int success = 0, failed = 0, skipped = 0;
        long totalSavedBytes = 0;

        var encoder = new WebpEncoder { Quality = quality };

        foreach (var filePath in files)
        {
            var outputPath = Path.ChangeExtension(filePath, ".webp");

            // Zaten WebP varsa atla
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

                using var image = await SixLabors.ImageSharp.Image.LoadAsync(filePath);
                image.Mutate(x => x.AutoOrient()); // ← bunu ekle
                await image.SaveAsWebpAsync(outputPath, encoder);

                var newSize = new FileInfo(outputPath).Length;
                var savedBytes = originalSize - newSize;
                var savedPercent = (double)savedBytes / originalSize * 100;
                totalSavedBytes += savedBytes;

                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"[OK]    {Path.GetFileName(filePath)} " +
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
                Console.WriteLine($"[HATA]  {Path.GetFileName(filePath)} → {ex.Message}");
                Console.ResetColor();
                failed++;
            }
        }

        // Özet
        Console.WriteLine("\n" + new string('─', 50));
        Console.WriteLine($"Tamamlandı!");
        Console.WriteLine($"  ✔ Başarılı : {success}");
        Console.WriteLine($"  ✘ Hatalı   : {failed}");
        Console.WriteLine($"  ↷ Atlanan  : {skipped}");
        Console.WriteLine($"  💾 Kazanılan alan: {FormatBytes(totalSavedBytes)}");
        Console.WriteLine(new string('─', 50));
    }

    static string FormatBytes(long bytes)
    {
        if (bytes < 1024) return $"{bytes} B";
        if (bytes < 1024 * 1024) return $"{bytes / 1024.0:F1} KB";
        return $"{bytes / (1024.0 * 1024):F1} MB";
    }
}