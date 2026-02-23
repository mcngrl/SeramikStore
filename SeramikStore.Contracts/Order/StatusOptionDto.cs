using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Order
{
    public class StatusOptionDto
    {
        public int OrderStatusCode { get; set; }
        public string Aciklama { get; set; } = null!;
    }
}
