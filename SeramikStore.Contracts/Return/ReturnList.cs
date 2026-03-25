using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Return
{
    public class ReturnList
    {
        public int OrderId { get; set; }
        public List<ReturnHeaderDto> Headers { get; set; }
    }
}
