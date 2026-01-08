
using Microsoft.Extensions.Configuration;
using System.Security.AccessControl;

var configuration = new ConfigurationBuilder()
    .AddJsonFile("appsettings.json", optional: false)
    .Build();


string? connectionString = configuration.GetConnectionString("DefaultConnection");

try
{

	Scripter.Main(connectionString);
}
catch (Exception ex)
{

	Console.WriteLine(ex.Message);
}
