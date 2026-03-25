using SeramikStore.Contracts.Order;
using SeramikStore.Contracts.Return;
using SeramikStore.Entities;
using SeramikStore.Entities.Enums;
using SeramikStore.Services.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IReturnService
    {
        List<ReturnHeaderDto> GetReturnsByOrderId(int orderId, int userId);

        List<ReturnCreateItemDto> GetOrderForNewReturn(int orderId, int userId);

 
       (int Result, string Message) CreateReturn(ReturnCreateDto model);
        
    }
}
