using SeramikStore.Contracts.Return;

namespace SeramikStore.Web.ViewModels
{
    public class ReturnCreateViewModel
    {
        public int OrderId { get; set; }
        public string Reason { get; set; }
        public List<ReturnCreateItemDto> Items { get; set; }
    }
}
