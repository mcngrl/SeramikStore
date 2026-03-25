using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Return
{
    public class ReturnCreateViewDto
    {
        public int OrderId { get; set; }
        public string Reason { get; set; }
        public List<ReturnCreateItemDto> Items { get; set; }
    }
}
