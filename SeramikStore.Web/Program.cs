using Microsoft.AspNetCore.Localization;
using SeramikStore.Services;
using SeramikStore.Services.Email;
using SeramikStore.Web.Localization;
using SeramikStore.Web.Options;
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
    new CultureInfo("en-US"),
    new CultureInfo("fr-FR"),
    new CultureInfo("de-DE"),
    new CultureInfo("it-IT"),
    new CultureInfo("ru-RU"),
    new CultureInfo("el-GR"),
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
builder.Services.AddScoped<IReturnService, ReturnService>();
builder.Services.AddScoped<IReasonService, ReasonService>();
builder.Services.AddScoped<IOrderReturnManager, OrderReturnManager>();

builder.Services.Configure<EmailSettings>(
    builder.Configuration.GetSection("EmailSettings"));

builder.Services.Configure<CompanyOptions>(
    builder.Configuration.GetSection("Company")
);

builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddLogging();

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

#if DEBUG
app.MapControllerRoute(
    name: "devnotes",
    pattern: "dev-notes",
    defaults: new { controller = "DevNotes", action = "Index" });
#endif

app.Use(async (context, next) =>
{
    if (!context.Session.Keys.Contains("session_UserId"))
    {
        if (context.Request.Cookies.TryGetValue("remember_me", out var token))
        {
            var user = context.RequestServices
                .GetRequiredService<IUserService>()
                .GetByRememberMeToken(token);

            if (user != null && user.RememberMeExpire > DateTime.UtcNow)
            {
                context.Session.SetInt32("session_UserId", user.Id);
                context.Session.SetString("session_UserFullName", user.FullName);
                context.Session.SetString("session_RoleName", user.RoleName);
                context.Session.SetString("session_Email", user.Email);
                context.Session.SetString("session_Avatar", user.Avatar);
            }
        }
    }

    await next();
});


app.Run();
