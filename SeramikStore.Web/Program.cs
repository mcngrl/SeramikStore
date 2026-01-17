using Microsoft.AspNetCore.Localization;
using Microsoft.Extensions.DependencyInjection;
using SeramikStore.Services;
using System.Globalization;
using System.Numerics;
using System.Runtime.ConstrainedExecution;



var builder = WebApplication.CreateBuilder(args);

builder.Configuration
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json",
                  optional: true, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.local.json",
                  optional: true, reloadOnChange: true)
    .AddEnvironmentVariables();




// Add services to the container.
builder.Services.AddControllersWithViews();
//builder.Services.AddControllersWithViews(options =>
//{
//    options.ModelBinderProviders.Insert(0, new DecimalModelBinderProvider());
//});


var supportedCultures = new[]
{
    new CultureInfo("tr-TR")
};

builder.Services.Configure<RequestLocalizationOptions>(options =>
{
    options.DefaultRequestCulture = new RequestCulture("tr-TR");
    options.SupportedCultures = supportedCultures;
    options.SupportedUICultures = supportedCultures;

    // ⚠️ BUNU EKLE (ÇOK ÖNEMLİ)
    options.RequestCultureProviders.Clear();
});




builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
//builder.Services.AddScoped<IAuthentication, AuthenticationService>();
builder.Services.AddScoped<ICurrencyService, CurrencyService>();
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ICartService, CartService>();
builder.Services.AddScoped<ICategoryService, CategoryService>();
builder.Services.AddScoped<IProductImageService, ProductImageService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUserAddressService, UserAddressService>();
builder.Services.AddScoped<IOrderService, OrderService>();



// AddScoped
// Her HTTP request için 1 kez oluşturulur

// AddTransient
// Her istendiğinde yeni nesne
// Hafif servisler için
// DB erişimi için genelde önerilmez

// AddSingleton
// Uygulama boyunca tek nesne
// Cache, Logger gibi yapılar için
// SqlConnection olan sınıflar için ASLA

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;

}
);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}


app.UseHttpsRedirection();
app.UseSession();



app.UseRequestLocalization();


app.UseRouting();

app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();


app.Run();


