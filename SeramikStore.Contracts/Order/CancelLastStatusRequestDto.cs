namespace SeramikStore.Contracts.Order
{
    public class CancelLastStatusRequestDto
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
    }
}