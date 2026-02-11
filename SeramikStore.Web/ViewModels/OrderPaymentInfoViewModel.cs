namespace SeramikStore.Web.ViewModels
{
    public class OrderPaymentInfoViewModel
    {
        public List<CartItem> Items { get; set; }
        public UserAddressViewModel Address { get; set; }

        public decimal TotalAmount { get; set; }
        public decimal CargoAmount { get; set; }
        public decimal GrandTotal { get; set; }

        public string Iban { get; set; }
        public string BankName { get; set; }
        public string BankAccountHolder { get; set; }
    }

}
