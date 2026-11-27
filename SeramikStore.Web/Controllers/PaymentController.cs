using Microsoft.AspNetCore.Mvc;
using SeramikStore.Contracts.Order;
using SeramikStore.Entities.Enums;
using SeramikStore.Services;
using System.Net;
// + OrderController'daki using'lerin aynısı: IOrderService, INotificationService namespace'leri

namespace SeramikStore.Web.Controllers
{
    // Callback'i ayrı controller'a koydum: OrderController'daki olası giriş/oturum filtresi
    // iyzico'dan gelen çapraz-site POST'u engellemesin diye.
    public class PaymentController : Controller
    {
        private readonly IOrderService _orderService;
        private readonly IIyzicoService _iyzico;
        private readonly IOrderPaymentService _orderPayment;
        private readonly INotificationService _notificationService;   // OrderController'daki tipin aynısı
        private readonly IAppLogService _appLogService;

        public PaymentController(
            IOrderService orderService,
            IIyzicoService iyzico,
            IOrderPaymentService orderPayment,
            INotificationService notificationService,
            IAppLogService appLogService)
        {
            _orderService = orderService;
            _iyzico = iyzico;
            _orderPayment = orderPayment;
            _notificationService = notificationService;
            _appLogService = appLogService;

        }

        // ------------------------------------------------------------------
        // 1) Siparişi iyzico ödeme sayfasına gönder (GET: ilk ödeme ve "tekrar dene" için)
        // ------------------------------------------------------------------
        [HttpGet]
        public async Task<IActionResult> Start(int orderId)
        {
            var userId = HttpContext.Session.GetInt32("session_UserId");
            if (userId is null)
                return RedirectToAction("Index", "Home");

            // TODO-A: OrderInfo aksiyonunda siparişi getirdiğin metodun aynısı (userId ile, başkasının siparişi gelmemeli)

            var order = _orderService.GetDetailedOrderById(orderId);

            if (order == null || order.UserId != userId.Value)
                return RedirectToAction("Index", "Home");

            // Sadece "Ödeme Bekleniyor" (20) durumundaki sipariş ödenebilir
            if (order.OrderStatusCode != (int)OrderStatusCode.PaymentPending || _orderPayment.IsOrderPaid(orderId))
                return RedirectToAction("OrderInfo", "Order", new { id = orderId });

            if (order == null)
                return RedirectToAction("Index", "Home");

            if (order.OrderStatusCode == (int)OrderStatusCode.Cancelled || _orderPayment.IsOrderPaid(orderId))
                return RedirectToAction("OrderInfo", "Order", new { id = orderId });

            // TODO-C: kullanıcının e-posta adresi (iyzico için zorunlu). Session key'i veya kullanıcı servisi ile değiştir.
            var email = HttpContext.Session.GetString("session_Email") ?? "";

            var ip = HttpContext.Connection.RemoteIpAddress;
            var ipText = (ip == null || IPAddress.IsLoopback(ip))
                ? "85.34.78.112"   // localhost'ta test için
                : (ip.IsIPv4MappedToIPv6 ? ip.MapToIPv4().ToString() : ip.ToString());

            var lines = order.Items.Select(i => new IyzicoBasketLine
            {
                Id = i.ProductCode ?? "P",
                Name = i.ProductName ?? "Urun",
                Price = i.LineTotal
            }).ToList();

            if (order.CargoAmount > 0)
                lines.Add(new IyzicoBasketLine { Id = "KARGO", Name = "Kargo", Price = order.CargoAmount });

            var req = new IyzicoCheckoutRequest
            {
                OrderId = order.Id,
                UserId = userId.Value,
                CurrencyCode = order.CurrencyCode ?? "TRY",
                CallbackUrl = Url.Action("IyzicoCallback", "Payment", null, Request.Scheme)!,
                Ip = ipText,
                Locale = System.Globalization.CultureInfo.CurrentUICulture.TwoLetterISOLanguageName == "tr" ? "tr" : "en",
                BuyerName = order.Address?.Ad ?? "",
                BuyerSurname = order.Address?.Soyad ?? "",
                BuyerEmail = email,
                BuyerPhone = order.Address?.Telefon ?? "",
                City = order.Address?.Il ?? "",
                AddressText = $"{order.Address?.Adres} {order.Address?.Ilce}".Trim(),
                Lines = lines
            };

            var init = await _iyzico.StartAsync(req);
            
            if (!init.Success)
            {
                // TODO: mevcut AppLogs loglama çağrını buraya ekle (init.ErrorCode, init.ErrorMessage, orderId)


                await _appLogService.ErrorAsync("Iyzico", "SendAsync",
                      $"Iyzico E.Code: {init.ErrorCode} | E.Message: {init.ErrorMessage} | OrderId: {orderId} | ");

                TempData["Error"] = "Ödeme sayfası açılamadı. Lütfen sipariş sayfasından tekrar deneyin.";
                return RedirectToAction("OrderInfo", "Order", new { id = orderId });
            }

            await _appLogService.SuccessAsync("Iyzico", "SendAsync",
             $"Iyzico başlatma başarılı. OrderId: {orderId} | Token: {init.Token}");

            _orderPayment.AddInitiated(order.Id, init.Token!, init.Price, req.CurrencyCode);
            return Redirect(init.PaymentPageUrl!);
        }

        // ------------------------------------------------------------------
        // 2) iyzico kullanıcıyı buraya POST ile döndürür (form alanı: token)
        //    Çapraz-site POST olduğu için antiforgery ve oturum yok; siparişi token'dan buluyoruz.
        // ------------------------------------------------------------------
        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> IyzicoCallback([FromForm] string token)
        {
            var pay = string.IsNullOrWhiteSpace(token) ? null : _orderPayment.GetByToken(token);
            if (pay == null)
                return RedirectToAction("Index", "Home");

            // Sonucu her zaman iyzico'dan sunucu tarafında sorgula
            var r = await _iyzico.RetrieveAsync(token);

            // Sipariş eşleşmesi ve tutar kontrolü (taksit farkı olursa PaidPrice >= Price)
            var valid = r.Success && r.OrderId == pay.OrderId && r.PaidPrice >= pay.Price;

            var alreadyPaid = _orderPayment.IsOrderPaid(pay.OrderId);

            var first = _orderPayment.Complete(token, valid, r.PaymentId, r.PaidPrice,
                r.ErrorCode, valid ? null : (r.ErrorMessage ?? "Doğrulama hatası"));

            if (!first)   // aynı callback ikinci kez geldi (sayfa yenileme vb.)
                return RedirectToAction("OrderInfo", "Order", new { id = pay.OrderId });

            if (valid)
            {
                if (!alreadyPaid)
                {
                    // TODO-B: mevcut "ödeme alındı" durum geçişini çağır; admin panelinde ödemeyi onaylarken
                    // kullandığın metodun aynısı olsun ki orada tetiklenen her şey (stok, bildirim vb.) burada da olsun.
         
                    var upd = _orderService.UpdateOrderStatus(pay.OrderId, (int)OrderStatusCode.PaymentReceived , pay.UserId);
                    if (upd.IsSuccess)   // başarı değeri teyit edilecek, aşağıya bak
                    {
                        await _notificationService.SendToAdmin(
                        "💳 Kartla Ödeme Alındı",
                        $"#{pay.OrderId} nolu sipariş için kartla ödeme alındı.");
                    }
                    else
                    {
                        await _notificationService.SendToAdmin(
                        "⚠️ Ödeme Alındı, Durum Güncellenemedi",
                        $"#{pay.OrderId} nolu sipariş için kartla ödeme alındı (PaymentId: {r.PaymentId}) ama sipariş durumu 'Ödeme Alındı'ya geçirilemedi. Elle kontrol edin.");

                    }
                }
                else
                {
                    await _notificationService.SendToAdmin(
                        "⚠️ Mükerrer Ödeme",
                        $"#{pay.OrderId} nolu sipariş için ikinci bir kart ödemesi alındı (PaymentId: {r.PaymentId}). İade gerekebilir.");
                }

                TempData["Success"] = "Ödemeniz alındı. Teşekkür ederiz.";
            }
            else
            {
                // TODO: AppLogs'a r.ErrorCode / r.ErrorMessage yaz
                TempData["Error"] = "Ödeme tamamlanamadı. Sipariş sayfasından tekrar deneyebilirsiniz.";
            }

            return RedirectToAction("OrderInfo", "Order", new { id = pay.OrderId });
        }
    }
}