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
string projectRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.FullName;

string FolderForEntity = Path.Combine(solutionRoot, "SeramikStore.Entities");
string FolderForSP = Path.Combine(projectRoot, "CRUDSP");



bool menu = true;
string tabloadi = "";
string classadi = "";
string outputFileForEntity = "";
string outputFileForSP = "";

while (menu)
{
    Console.Clear();
    tabloadi = "";
    outputFileForEntity = "";
    Console.WriteLine("EntityWriter");
    Console.WriteLine("CONNECTION STRING:");
    Console.WriteLine(connectionString);
    Console.WriteLine("--------------------");
    Console.WriteLine("Connection Stringdeki veritabanınındaki girilen Tablo için Entity Classi oluşacak.");
    Console.WriteLine("--------------------");
    Console.Write("Tablo Adı ? : ");
    tabloadi = Console.ReadLine()?.Trim();
    classadi = tabloadi;

    outputFileForEntity = Path.Combine(FolderForEntity, $"{tabloadi}.cs");
    outputFileForSP = Path.Combine(FolderForSP, $"SP_CRUD_{tabloadi}_{DateTime.Now:yyyyMMddHHmmss}.sql");

    Console.WriteLine("Entity için Hedef Dosya");
    Console.WriteLine(outputFileForEntity);
    Console.WriteLine("CRUD SPleri için Hedef Dosya");
    Console.WriteLine(outputFileForSP);

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
    EntityCreator.FileCreator.RunForEntityClass(connectionString, "dbo", tabloadi, classadi, "SeramikStore.Entities", outputFileForEntity);
    Console.WriteLine("BAŞARI İLE SONLANDI. Entity");
    Console.WriteLine(tabloadi);
    Console.WriteLine(outputFileForEntity);
}
catch (Exception ex)
{
    Console.WriteLine("HATA oluştu EntityCreator.Creator");
    Console.WriteLine(ex);
    Console.ReadLine();
}

try
{
    EntityCreator.FileCreator.RunCRUDSPSql(connectionString, "dbo", tabloadi, classadi, "SeramikStore.Entities", outputFileForSP);
    Console.WriteLine("BAŞARI İLE SONLANDI. CRUDSP");
    Console.WriteLine(tabloadi);
    Console.WriteLine(outputFileForSP);
}
catch (Exception ex)
{
    Console.WriteLine("HATA oluştu EntityCreator.Creator Hata oluştu:");
    Console.WriteLine(ex);
    Console.ReadLine();
}



Console.WriteLine("Programdan çıkmak için ENTER'a basınız.");
Console.ReadLine();
