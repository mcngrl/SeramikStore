namespace SeramikStore.Entities
{
    public class UserAddress
    {
        public int Id { get; set; }
        public int UserId { get; set; }

        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string Telefon { get; set; }

        public string Il { get; set; }
        public string Ilce { get; set; }
        public string Mahalle { get; set; }
        public string Adres { get; set; }

        public string Baslik { get; set; }
        public bool IsDefault { get; set; }
    }
}
