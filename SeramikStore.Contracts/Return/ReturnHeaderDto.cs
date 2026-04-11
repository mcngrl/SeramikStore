
using SeramikStore.Contracts.Reason;

namespace SeramikStore.Contracts.Return
{
    public class ReturnHeaderDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public DateTime ReturnRequestDate { get; set; }
        public int OrderId { get; set; }
        public ReasonDto ReturnReason { get; set; }
        public string ManuelDescriptionForReason { get; set; }
        public int StatusForReturnCode { get; set; }
        public string StatusForReturnDesc { get; set; }
        public string BankName { get; set; }
        public string IBAN   { get; set; }
        public string AccountHolderName { get; set; }
       
        public List<ReturnDetailDto> Details { get; set; } = new();
    }
}
