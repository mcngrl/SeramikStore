using EntityCreator;
using Microsoft.Extensions.Configuration;

static string AskYesNoExit(string message)
{

    Console.WriteLine(message);
    Console.Write("Seçiminiz (E/H/C): ");
    return Console.ReadLine()?.Trim().ToUpper() ?? "H";
}

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

string solutionRoot = Directory.GetParent(AppContext.BaseDirectory)!.Parent!.Parent!.Parent!.Parent!.FullName;


List<Target> targets = new List<Target>
{
    //new Target(1,solutionRoot,@"EntityCreator\CRUDSP",false,$".generated.sql", new CrudSpAction()),
    //new Target(2,solutionRoot,"SeramikStore.Entities",false,".generated.cs", new EntityAction()),
    //new Target(3,solutionRoot,"SeramikStore.Contracts",true,"", new DtoAction()),
    //new Target(4,solutionRoot,"SeramikStore.Services",true,"", new ServiceAction()),
    //new Target(5,solutionRoot,"SeramikStore.Web",true,"", new ViewModelAction()),
    new Target(6,solutionRoot,@"SeramikStore.Web\Controllers",true,"Controller.generated.cs", new ControllerAction())
};


while (true)
{
    Console.Clear();
    Console.WriteLine("WELCOME TO ENTITY CREATOR");
    Console.WriteLine(new string('-', 100));
    Console.WriteLine("CONNECTION STRING:");
    Console.WriteLine(connectionStr);
    Console.WriteLine(new string('-', 100));

    Console.Write("Tablo Adı ? : ");
    string? tableName = Console.ReadLine()?.Trim();

    if (string.IsNullOrWhiteSpace(tableName))
    {
        Console.WriteLine("Tablo adı boş olamaz!");
        continue;
    }


  
    foreach (var targetItem in targets)
    {
        targetItem.TableName = tableName;
        targetItem.ConnectionString = connectionStr;

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
    Console.WriteLine();

    // =======================
    // BAŞA DÖN?
    // =======================
    var again = AskYesNoExit("Yeni bir tablo için devam etmek ister misiniz?");
    if (again != "E")
        return;
}
