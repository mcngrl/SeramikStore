using EntityCreator;
using Microsoft.Extensions.Configuration;
using System.Linq;

// =====================
// MENÜLER
// =====================

static string AskTableNameFromDb(string connectionString)
{
    var tables = Helper.GetTableNames(connectionString);

    if (!tables.Any())
    {
        Console.WriteLine("Veritabanında tablo bulunamadı!");
        return string.Empty;
    }

    Console.WriteLine("Tablo Seçiniz:");
    Console.WriteLine(new string('-', 40));

    for (int i = 0; i < tables.Count; i++)
        Console.WriteLine($"{i + 1}) {tables[i]}");

    Console.WriteLine();
    Console.Write("Seçiminiz (numara) : ");

    if (!int.TryParse(Console.ReadLine(), out var choice))
        return string.Empty;

    if (choice < 1 || choice > tables.Count)
        return string.Empty;

    return tables[choice - 1];
}

static int AskMainMenu()
{
    Console.WriteLine("1) Tüm layer’ları üret");
    Console.WriteLine("2) Layer seçerek üret");
    Console.WriteLine("3) Çıkış");
    Console.Write("Seçiminiz: ");
    return int.TryParse(Console.ReadLine(), out var x) ? x : 0;
}

static List<int> AskLayerSelection()
{
    Console.WriteLine("Layer Seçimi:");
    Console.WriteLine("1 - CRUD SP");
    Console.WriteLine("2 - Entity");
    Console.WriteLine("3 - DTO");
    Console.WriteLine("4 - Service");
    Console.WriteLine("5 - ViewModel");
    Console.WriteLine("6 - Controller");
    Console.WriteLine("7 - View");
    Console.Write("Seçimler (1,3,5): ");

    var input = Console.ReadLine();
    return input?
        .Split(',', StringSplitOptions.RemoveEmptyEntries)
        .Select(x => int.TryParse(x.Trim(), out var i) ? i : -1)
        .Where(x => x > 0)
        .Distinct()
        .ToList()
        ?? new();
}

static string AskYesNoExit(string message)
{
    Console.WriteLine(message);
    Console.Write("Seçiminiz (E/H/C): ");
    return Console.ReadLine()?.Trim().ToUpper() ?? "H";
}

// =====================
// CONFIG
// =====================
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.Development.local.json", optional: false)
    .Build();

string? connectionStr = configuration.GetConnectionString("DefaultConnection");
if (string.IsNullOrWhiteSpace(connectionStr))
{
    Console.WriteLine("Connection string bulunamadı!");
    return;
}

string solutionRoot =
    Directory.GetParent(AppContext.BaseDirectory)!
        .Parent!.Parent!.Parent!.Parent!.FullName;

// =====================
// TARGETS
// =====================
List<Target> targets = new()
{
    new Target(1, solutionRoot, @"EntityCreator\CRUDSP", false, ".generated.sql", new CrudSpAction()),
    new Target(2, solutionRoot, "SeramikStore.Entities", false, ".generated.cs", new EntityAction()),
    new Target(3, solutionRoot, "SeramikStore.Contracts", true, "", new DtoAction()),
    new Target(4, solutionRoot, "SeramikStore.Services", true, "", new ServiceAction()),
    new Target(5, solutionRoot, "SeramikStore.Web", true, "", new ViewModelAction()),
    new Target(6, solutionRoot, @"SeramikStore.Web\Controllers", true, "Controller.generated.cs", new ControllerAction()),
    new Target(7, solutionRoot, @"SeramikStore.Web\Views", true, "", new ViewAction()),
};

// =====================
// MAIN LOOP
// =====================
while (true)
{
    Console.Clear();
    Console.WriteLine("WELCOME TO ENTITY CREATOR");
    Console.WriteLine(new string('-', 100));

    var mainChoice = AskMainMenu();
    if (mainChoice == 3)
        return;

    List<Target> selectedTargets;

    if (mainChoice == 1)
    {
        // TÜM LAYER’LAR
        selectedTargets = targets;
    }
    else if (mainChoice == 2)
    {
        // SEÇEREK
        var selections = AskLayerSelection();
        selectedTargets = targets
            .Where(t => selections.Contains(t.OrderNo))
            .ToList();

        if (!selectedTargets.Any())
        {
            Console.WriteLine("Hiç layer seçilmedi!");
            Console.ReadKey();
            continue;
        }
    }
    else
    {
        Console.WriteLine("Geçersiz seçim!");
        Console.ReadKey();
        continue;
    }

    Console.WriteLine(new string('-', 100));
    //Console.Write("Tablo Adı ? : ");
    //string? tableName = Console.ReadLine()?.Trim();

    //if (string.IsNullOrWhiteSpace(tableName))
    //{
    //    Console.WriteLine("Tablo adı boş olamaz!");
    //    Console.ReadKey();
    //    continue;
    //}



    Console.WriteLine("Tablo nasıl seçilsin?");
    Console.WriteLine("1) Veritabanından seç");
    Console.WriteLine("2) Manuel tablo adı gir");
    Console.Write("Seçiminiz: ");

    var tableMode = Console.ReadLine();

    string tableName = string.Empty;

    if (tableMode == "1")
    {
        tableName = AskTableNameFromDb(connectionStr);
    }
    else if (tableMode == "2")
    {
        Console.Write("Tablo Adı: ");
        tableName = Console.ReadLine()?.Trim() ?? "";
    }

    if (string.IsNullOrWhiteSpace(tableName))
    {
        Console.WriteLine("Geçerli bir tablo seçilmedi!");
        Console.ReadKey();
        continue;
    }






    Console.Write("Tablo: " + tableName);



    // =======================
    // GENERATION
    // =======================
    foreach (var targetItem in selectedTargets)
    {
        targetItem.TableName = tableName;
        targetItem.ConnectionString = connectionStr;

        Console.WriteLine();
        Console.WriteLine(targetItem.WelcomeText);
        Console.WriteLine(targetItem.FileFullPath);

        var ans = AskYesNoExit("Devam edilsin mi?");
        if (ans == "C") return;

        if (ans == "E")
        {
            targetItem.Execute();
            Console.WriteLine($"{targetItem.ProjectName} başarıyla oluşturuldu.");
        }
    }

    Console.WriteLine();
    Console.WriteLine($"{tableName} için code generation tamamlandı.");

    var again = AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?");
    if (again != "E")
        return;
}
