namespace SeramikStore.Services.DTOs
{
    public class OrderCreateDto
    {
        public int AddressId { get; set; }  
        public decimal CargoAmount { get; set; }
        public int UserId { get; set; }
    }

}