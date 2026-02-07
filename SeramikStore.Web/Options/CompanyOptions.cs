namespace SeramikStore.Web.Options
{
    public class CompanyOptions
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string LogoUrl { get; set; }
        public string WebsiteUrl { get; set; }

        public SocialMediaOptions SocialMedia { get; set; }
        public BankAccountOptions BankAccount { get; set; }
    }
}
