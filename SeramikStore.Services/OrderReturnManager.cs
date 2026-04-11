using SeramikStore.Contracts.Return;
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


    public void MarkCanceleableReturns(List<ReturnHeaderDto> list)
    {
        bool hasFinalReturn = list.Any(x => x.IsFinalReturnForOrder);

        if (hasFinalReturn)
        {
            foreach (var item in list)
            {
                item.IsCancelable = false;
                if (item.IsFinalReturnForOrder && item.StatusForReturnCode != (int)ReturnStatusCode.Cancelled)
                {
                    item.IsCancelable = true;
                }
            }
        }
        else
        {
            foreach (var item in list)
            {
                item.IsCancelable = false;
                if (item.StatusForReturnCode != (int)ReturnStatusCode.Cancelled)
                {
                    item.IsCancelable = true;
                }
            }
        }

    }

}