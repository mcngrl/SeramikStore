using Microsoft.Extensions.Configuration;
using System.Globalization;
using Iyzipay;
using Iyzipay.Model;
using Iyzipay.Request;

// NuGet: Iyzipay (test projesinde çalışan sürümle aynı)
// Dosyayı Services/Payment klasörüne koy; namespace'i projene göre ayarla.
namespace SeramikStore.Services
{
    public class IyzicoBasketLine
    {
        public string Id { get; set; } = "";
        public string Name { get; set; } = "";
        public decimal Price { get; set; }          // satır toplamı (adet * birim fiyat)
    }

    public class IyzicoCheckoutRequest
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public string CurrencyCode { get; set; } = "TRY";   // "TL" gelirse TRY'ye çevrilir
        public string CallbackUrl { get; set; } = "";
        public string Ip { get; set; } = "";
        public string Locale { get; set; } = "tr";          // "tr" | "en"

        public string BuyerName { get; set; } = "";
        public string BuyerSurname { get; set; } = "";
        public string BuyerEmail { get; set; } = "";
        public string BuyerPhone { get; set; } = "";
        public string City { get; set; } = "";
        public string AddressText { get; set; } = "";

        public List<IyzicoBasketLine> Lines { get; set; } = new();
    }

    public class IyzicoInitResult
    {
        public bool Success { get; set; }
        public string? Token { get; set; }
        public string? PaymentPageUrl { get; set; }
        public decimal Price { get; set; }
        public string? ErrorCode { get; set; }
        public string? ErrorMessage { get; set; }
    }

    public class IyzicoPaymentResult
    {
        public bool Success { get; set; }          // Status=success && PaymentStatus=SUCCESS
        public int OrderId { get; set; }           // BasketId'den
        public decimal PaidPrice { get; set; }
        public string? PaymentId { get; set; }
        public string? ErrorCode { get; set; }
        public string? ErrorMessage { get; set; }
    }

    public interface IIyzicoService
    {
        Task<IyzicoInitResult> StartAsync(IyzicoCheckoutRequest r);
        Task<IyzicoPaymentResult> RetrieveAsync(string token, string locale = "tr");
    }

    public class IyzicoService : IIyzicoService
    {
        private readonly Iyzipay.Options _options;

        public IyzicoService(IConfiguration config)
        {
            //_options = new Iyzipay.Options
            //{
            //    ApiKey = config["Iyzico:ApiKey"] ?? throw new InvalidOperationException("Iyzico:ApiKey eksik"),
            //    SecretKey = config["Iyzico:SecretKey"] ?? throw new InvalidOperationException("Iyzico:SecretKey eksik"),
            //    BaseUrl = config["Iyzico:BaseUrl"] ?? "https://sandbox-api.iyzipay.com"
            //};

            var apiKey = config["Iyzico:ApiKey"]?.Trim();
            var secretKey = config["Iyzico:SecretKey"]?.Trim();
            if (string.IsNullOrWhiteSpace(apiKey) || string.IsNullOrWhiteSpace(secretKey))
                throw new InvalidOperationException("Iyzico:ApiKey / Iyzico:SecretKey eksik ya da boş");

            _options = new Iyzipay.Options
            {
                ApiKey = apiKey,
                SecretKey = secretKey,
                BaseUrl = config["Iyzico:BaseUrl"]?.Trim() is { Length: > 0 } u ? u : "https://sandbox-api.iyzipay.com"
            };

            System.Diagnostics.Debug.WriteLine(
    $"IYZICO CFG -> apiKey len={_options.ApiKey.Length}, starts='{_options.ApiKey[..Math.Min(8, _options.ApiKey.Length)]}', " +
    $"secret len={_options.SecretKey.Length}, secret starts='{_options.SecretKey[..Math.Min(8, _options.SecretKey.Length)]}', " +
    $"baseUrl={_options.BaseUrl}");

        }

        public async Task<IyzicoInitResult> StartAsync(IyzicoCheckoutRequest r)
        {
            try
            {
                var lines = r.Lines.Where(l => l.Price > 0).ToList();
                var total = lines.Sum(l => l.Price);
                var price = Fmt(total);
                var orderKey = r.OrderId.ToString(CultureInfo.InvariantCulture);

                var req = new CreateCheckoutFormInitializeRequest
                {
                    Locale = r.Locale,
                    ConversationId = orderKey,
                    Price = price,
                    PaidPrice = price,
                    Currency = MapCurrency(r.CurrencyCode),
                    BasketId = orderKey,
                    PaymentGroup = PaymentGroup.PRODUCT.ToString(),
                    CallbackUrl = r.CallbackUrl
                };

                req.Buyer = new Buyer
                {
                    Id = "U" + r.UserId,
                    Name = Safe(r.BuyerName, "Musteri"),
                    Surname = Safe(r.BuyerSurname, "Musteri"),
                    GsmNumber = NormalizePhone(r.BuyerPhone),
                    Email = r.BuyerEmail,
                    // TCKN toplamıyoruz. iyzico dokümanına göre bilinmiyorsa sabit değer gönderilebilir;
                    // canlıya geçmeden iyzico ile teyit et.
                    IdentityNumber = "11111111111",
                    RegistrationAddress = Safe(r.AddressText, "-"),
                    Ip = r.Ip,
                    City = Safe(r.City, "-"),
                    Country = "Turkey"
                };

                var address = new Address
                {
                    ContactName = (r.BuyerName + " " + r.BuyerSurname).Trim(),
                    City = Safe(r.City, "-"),
                    Country = "Turkey",
                    Description = Safe(r.AddressText, "-")
                };
                req.ShippingAddress = address;
                req.BillingAddress = address;

                req.BasketItems = lines.Select(l => new BasketItem
                {
                    Id = l.Id,
                    Name = Safe(l.Name, "Urun"),
                    Category1 = "Seramik",
                    ItemType = BasketItemType.PHYSICAL.ToString(),
                    Price = Fmt(l.Price)
                }).ToList();

                var init = await CheckoutFormInitialize.Create(req, _options);

                if (init.Status != "success")
                    return new IyzicoInitResult { Success = false, ErrorCode = init.ErrorCode, ErrorMessage = init.ErrorMessage };

                return new IyzicoInitResult
                {
                    Success = true,
                    Token = init.Token,
                    PaymentPageUrl = init.PaymentPageUrl,
                    Price = total
                };
            }
            catch (Exception ex)
            {
                return new IyzicoInitResult { Success = false, ErrorCode = "EXCEPTION", ErrorMessage = ex.Message };
            }
        }

        public async Task<IyzicoPaymentResult> RetrieveAsync(string token, string locale = "tr")
        {
            try
            {
                var res = await CheckoutForm.Retrieve(new RetrieveCheckoutFormRequest
                {
                    Locale = locale,
                    Token = token
                }, _options);

                int.TryParse(res.BasketId, out var orderId);
                decimal.TryParse(res.PaidPrice, NumberStyles.Any, CultureInfo.InvariantCulture, out var paid);

                return new IyzicoPaymentResult
                {
                    Success = res.Status == "success" && res.PaymentStatus == "SUCCESS",
                    OrderId = orderId,
                    PaidPrice = paid,
                    PaymentId = res.PaymentId,
                    ErrorCode = res.ErrorCode,
                    ErrorMessage = res.ErrorMessage
                };
            }
            catch (Exception ex)
            {
                return new IyzicoPaymentResult { Success = false, ErrorCode = "EXCEPTION", ErrorMessage = ex.Message };
            }
        }

        private static string Fmt(decimal v) => v.ToString("0.00", CultureInfo.InvariantCulture);

        private static string Safe(string? s, string fallback) => string.IsNullOrWhiteSpace(s) ? fallback : s.Trim();

        private static string MapCurrency(string? c)
        {
            var x = (c ?? "").Trim().ToUpperInvariant();
            return x is "TL" or "TRY" or "" ? "TRY" : x;
        }

        private static string NormalizePhone(string? p)
        {
            var d = new string((p ?? "").Where(char.IsDigit).ToArray());
            if (d.Length == 10 && d.StartsWith("5")) return "+90" + d;
            if (d.Length == 11 && d.StartsWith("05")) return "+9" + d;
            if (d.Length == 12 && d.StartsWith("90")) return "+" + d;
            return d.Length >= 10 ? "+" + d : "+905000000000";
        }
    }
}