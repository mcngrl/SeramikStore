using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities.Enums
{

    public enum ReturnStatusCode
    {
        NotAssigned = 0,
        AwaitingReturnShipment = 110,   // İade kargosunun gönderilmesi bekleniyor
        Completed = 120,                // Süreç tamamlandı
        Cancelled = 180,                // İade iptal edildi
    }
}

