using Microsoft.AspNetCore.Localization;
using SeramikStore.Services;
using SeramikStore.Web.Localization;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);

// =====================
// CONFIGURATION
// =====================
builder.Configuration
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.local.json", optional: true)
    .AddEnvironmentVariables();

// =====================
// LOCALIZATION
// =====================
builder.Services.AddLocalization(options =>
{
    options.ResourcesPath = "Resources";
});

builder.Services.AddControllersWithViews()
        .AddViewLocalization()
       .AddDataAnnotationsLocalization(options =>
       {
           options.DataAnnotationLocalizerProvider = (type, factory) =>
               factory.Create(typeof(AccountResource));
       });

// Desteklenen diller
var supportedCultures = new[]
{
    new CultureInfo("tr-TR"),
    new CultureInfo("en-US")
};

builder.Services.Configure<RequestLocalizationOptions>(options =>
{
    options.DefaultRequestCulture = new RequestCulture("tr-TR");

    options.SupportedCultures = supportedCultures;
    options.SupportedUICultures = supportedCultures;

    // ÖNEMLİ: Dil değiştirme sırası
    options.RequestCultureProviders = new IRequestCultureProvider[]
    {
        new QueryStringRequestCultureProvider(), // ?culture=en-US
        new CookieRequestCultureProvider(),      // .AspNetCore.Culture
        new AcceptLanguageHeaderRequestCultureProvider()
    };
});

// =====================
// DEPENDENCY INJECTION
// =====================
builder.Services.AddHttpContextAccessor();

builder.Services.AddScoped<ICurrencyService, CurrencyService>();
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ICartService, CartService>();
builder.Services.AddScoped<ICategoryService, CategoryService>();
builder.Services.AddScoped<IProductImageService, ProductImageService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUserAddressService, UserAddressService>();
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddScoped<IPotansiyelService, PotansiyelService>();
// =====================
// SESSION
// =====================
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

var app = builder.Build();

// =====================
// MIDDLEWARE PIPELINE
// =====================
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseRequestLocalization(); // ⚠️ TEK VE DOĞRU YER

app.UseSession();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
