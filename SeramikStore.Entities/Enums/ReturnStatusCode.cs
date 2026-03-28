using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities.Enums
{

    public enum ReturnStatusCode
    {
        RequestUnderReview = 110,     // Talebiniz Değerlendiriliyor
        ReturnApproved = 120,         // İade Talebiniz Kabul Edildi
        ReturnRejected = 130,         // İade Talebiniz Reddedildi
        RefundCompleted = 140,        // Geri Ödeme Gerçekleşti
        GiftVoucherIssued = 150,      // Hediye Kuponu Tanımlandı
        ReturnCancelled = 180         // İade Talebiniz İptal Edildi
    }
}

