using SeramikStore.Entities.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public static class OrderStatusTransitions
    {
        public static List<OrderStatusCode> GetAllowedNext(OrderStatusCode current)
        {
            return current switch
            {
                OrderStatusCode.WaitingPayment =>
                    new() { OrderStatusCode.PaymentReceived, OrderStatusCode.Cancelled },

                OrderStatusCode.PaymentReceived =>
                    new() { OrderStatusCode.Approved, OrderStatusCode.Cancelled },

                OrderStatusCode.Approved =>
                    new() { OrderStatusCode.Preparing, OrderStatusCode.Cancelled },

                OrderStatusCode.Preparing =>
                    new() { OrderStatusCode.Shipped },

                OrderStatusCode.Shipped =>
                    new() { OrderStatusCode.Delivered },

                _ => new()
            };
        }
    }
}
