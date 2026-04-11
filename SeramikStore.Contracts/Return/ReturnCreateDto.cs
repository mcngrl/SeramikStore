using SeramikStore.Contracts.Reason;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Contracts.Return
{
    public class ReturnCreateDto 
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }

        public required string BankName { get; set; }
        public required string IBAN { get; set; }
        public required string AccountHolderName { get; set; }

        public ReasonDto ReturnReason { get; set; }
        public List<ReturnItemDto> Items { get; set; } = new();




    }
}
