
using Microsoft.Extensions.Configuration;
using System.Security.AccessControl;

var configuration = new ConfigurationBuilder()
    .AddJsonFile("appsettings.local.json", optional: false)
    .Build();


string? connectionString = configuration.GetConnectionString("DefaultConnection");

Console.WriteLine(connectionString);
Console.ReadLine();
try
{

    Scripter.Main(connectionString);
}
catch (Exception ex)
{

    Console.WriteLine(ex.Message);
}
