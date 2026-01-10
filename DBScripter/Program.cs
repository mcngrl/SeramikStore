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

//string outputFile = Path.Combine(
//    Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
//    "FullDatabaseScript.sql");

string projectRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.FullName;

string scriptsFolder = Path.Combine(projectRoot, "DBScripts");
string fileName = $"DB{DateTime.Now:yyyyMMddHHmmss}.sql";

string outputFile = Path.Combine(scriptsFolder, fileName);


bool menu = true;

while (menu)
{
    Console.Clear();

    Console.WriteLine("CONNECTION STRING:");
    Console.WriteLine(connectionString);
    Console.WriteLine("--------------------");
    Console.WriteLine("Connection Stringdeki veritabanının tablo stored procedure ve datasının scripti hedeflenen folderda oluşturulucaktır.");
    Console.WriteLine("--------------------");
    Console.WriteLine("HEDEF:");
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
    Scripter.Main(connectionString, outputFile);
}
catch (Exception ex)
{
    Console.WriteLine("Hata oluştu:");
    Console.WriteLine(ex);
    Console.ReadLine();
}

Console.WriteLine("BAŞARI İLE SONLANDI.");
Console.WriteLine(fileName);
Console.WriteLine(outputFile);


Console.ReadLine();
