using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities.Enums
{
    public enum OrderStatusCode
    {
        Created = 10,
        WaitingPayment = 20,
        PaymentReceived = 25,
        Approved = 30,
        Preparing = 40,
        Shipped = 50,
        Delivered = 60,
        Cancelled = 70
    }
}
