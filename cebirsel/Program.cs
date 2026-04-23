
bool devam = true;

while (devam)
{
    Console.WriteLine("Tost ücretini Girin:");
    int x = int.TryParse(Console.ReadLine(), out int tempX) ? tempX : 0;

    Console.WriteLine("Cay ücretini Girin:");
    int y = int.TryParse(Console.ReadLine(), out int tempY) ? tempY : 0;

    int toplam = x + y;
    Console.WriteLine("Toplam: " + toplam);

    Console.WriteLine("Kişi sayısını Girin:");
    int z = int.TryParse(Console.ReadLine(), out int tempZ) ? tempZ : 0;

    toplam = z * (x + y);
    Console.WriteLine("Genel Toplam: " + toplam);

    Console.WriteLine("Devam etmek istiyor musunuz? (E/H)");
    string? cevap = Console.ReadLine();

    if (cevap is null || cevap.ToLower() != "e")
    {
        devam = false;
    }

    Console.Clear(); // ekranı temizler (isteğe bağlı)
}

Console.WriteLine("Program Bitti");
Console.ReadLine();