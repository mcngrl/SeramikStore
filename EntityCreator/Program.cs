using Microsoft.Extensions.Configuration;

var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.Development.local.json", optional: false)
    .Build();

string? connectionString = configuration.GetConnectionString("DefaultConnection");

if (string.IsNullOrWhiteSpace(connectionString))
{
    Console.WriteLine("Connection string bulunamadı!");
    return;
}


string solutionRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.Parent!.FullName;

string scriptsFolder = Path.Combine(solutionRoot, "SeramikStore.Entities");



bool menu = true;
string tabloadi = "";
string outputFile = "";

while (menu)
{
    Console.Clear();
    tabloadi = "";
    outputFile = "";
    Console.WriteLine("CONNECTION STRING:");
    Console.WriteLine(connectionString);
    Console.WriteLine("--------------------");
    Console.WriteLine("Connection Stringdeki veritabanınındaki girilen Tablo için Entity Classi oluşacak.");
    Console.WriteLine("--------------------");
    Console.Write("Tablo Adı ? : ");
    tabloadi = Console.ReadLine()?.Trim();

    string fileName = $"{tabloadi}.cs";
    outputFile = Path.Combine(scriptsFolder, fileName);
    Console.WriteLine("HEDED DOSYA");
    Console.WriteLine(outputFile);
    Console.WriteLine();
    Console.Write("DEVAM ET? (E/H): ");
    var cevap = Console.ReadLine()?.Trim().ToUpper();

    if (cevap == "E")
        menu = false;
    else if (cevap == "H")
        return;
}

try
{
    EntityCreator.Creator.Main(connectionString,"dbo", tabloadi, tabloadi, "SeramikStore.Entities", outputFile);
}
catch (Exception ex)
{
    Console.WriteLine("Hata oluştu:");
    Console.WriteLine(ex);
    Console.ReadLine();
}

Console.WriteLine("BAŞARI İLE SONLANDI.");
Console.WriteLine(tabloadi);
Console.WriteLine(outputFile);

Console.WriteLine("Porgramdan çıkmak için ENTER'a basınız.");
Console.ReadLine();
