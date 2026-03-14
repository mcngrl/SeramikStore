using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities.Enums
{
    public enum OrderStatusCode
    {
        SiparisOlusturdu = 10,
        OdemeBekleniyor =20,
        OdemeAlindi =30,
        SiparisOnaylandi=40,
        SiparisHazirlaniyor=50,
        KargoyaVerildi=60,
        TeslimEdildi =70,
        Iptal=80
    }
}
