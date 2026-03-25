using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Return
{
    public class ReturnItemDto
    {
        public int OrderDetailId { get; set; }
        public int ReturnQuantity { get; set; }
    }
}
