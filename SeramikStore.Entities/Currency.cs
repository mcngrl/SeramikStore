using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Entities
{
    public class Currency
    {
        public int CurrencyId { get; set; }
        public string Code { get; set; }          // USD, EUR, TRY
        public string Name { get; set; }          // US Dollar
        public string Symbol { get; set; }        // $, €, ₺
        public decimal ExchangeRate { get; set; }
        public bool IsDefault { get; set; }
        public bool IsActive { get; set; }
    }
}
