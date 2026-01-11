using SeramikStore.Entities;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IOrderService
    {
        OrderCreateResultDto CreateOrder(OrderInfoDto orderInfo);
        OrderInfoDto GetOrderById(int orderId);
        List<OrderListItemDto> GetOrdersByUserId(int userId);
    }
}
