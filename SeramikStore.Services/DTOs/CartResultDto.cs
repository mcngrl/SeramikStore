namespace SeramikStore.Services.DTOs
{
	public class CartResultDto
	{
		public List<CartItemDto> Items { get; set; } = new();
		public CartSummaryDto Summary { get; set; }
	}

}