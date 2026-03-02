
namespace SeramikStore.Contracts.Order
{
    public class OrderStatusUpdateResultDto
    {
        public int Result { get; set; }
        public bool IsSuccess => Result == 1;
    }
}


