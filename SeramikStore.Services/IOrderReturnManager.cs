using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface IOrderReturnManager
    {
        bool IsOrderReturnable(int orderId, int userId);

    }
}
