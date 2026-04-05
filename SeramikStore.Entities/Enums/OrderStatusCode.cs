using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities.Enums
{

    public enum OrderStatusCode
    {
        NotAssigned = 0,          //  SiparisDurumuAtanmadi
        OrderCreated = 10,          //  SiparisOlusturdu
        PaymentPending = 20,          //  OdemeBekleniyor
        PaymentReceived = 30,          //  OdemeAlindi
        OrderApproved = 40,          //  SiparisOnaylandi
        OrderPreparing = 50,          //  SiparisHazirlaniyor
        Shipped = 60,          //  KargoyaVerildi
        Delivered = 70,          //  TeslimEdildi
        Cancelled = 80          //  Iptal
    }
}
