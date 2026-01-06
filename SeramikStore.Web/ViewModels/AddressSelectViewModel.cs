namespace SeramikStore.Web.ViewModels
{
    public class AddressSelectViewModel
    {
        public List<UserAddressViewModel> Addresses { get; set; }
        public int? SelectedAddressId { get; set; }

        public decimal ProductTotal { get; set; }
        public decimal CargoPrice { get; set; }
        public decimal GrandTotal => ProductTotal + CargoPrice;
    }
}
