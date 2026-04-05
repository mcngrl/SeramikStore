using SeramikStore.Entities.Enums;
using SeramikStore.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class OrderReturnManager : IOrderReturnManager
{
    private readonly IReturnService _returnService;

    public OrderReturnManager(IReturnService returnService)
    {
        _returnService = returnService;
    }

    public bool IsOrderReturnable(int orderId, int userId)
    {
        var result = _returnService.GetOrderForNewReturn(orderId, userId);

        bool IsReturnableByCustomer = true;

        if (result.OrderItems == null || result.OrderItems.Count == 0 || result.theOrderStatusCode != OrderStatusCode.Delivered)
        {
            IsReturnableByCustomer = false;
        }


        return IsReturnableByCustomer;
    }

}