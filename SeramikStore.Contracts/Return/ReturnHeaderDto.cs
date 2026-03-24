
namespace SeramikStore.Contracts.Return
{
    public class ReturnHeaderDto
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public DateTime ReturnRequestDate { get; set; }
        public int OrderId { get; set; }
        public string Reason { get; set; }

        public List<ReturnDetailDto> Details { get; set; } = new();
    }
}
