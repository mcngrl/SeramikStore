using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Return
{
    public class ReturnCreateDto
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public string Reason { get; set; }
        public List<ReturnItemDto> Items { get; set; }
    }
}
