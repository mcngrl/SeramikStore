namespace SeramikStore.Services.DTOs
{
    public class OrderAdminListItemDto
    {
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }

        public decimal ProductTotal { get; set; }
        public decimal CargoAmount { get; set; }
        public decimal GrandTotal { get; set; }

        public string OrderStatus { get; set; }

        // Kullanıcı Bilgisi
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }
}
