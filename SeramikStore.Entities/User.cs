namespace SeramikStore.Entities
{
    public class User
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime? BirthDate { get; set; }
        public bool IsActive { get; set; }
        public bool AcceptMembershipAgreement { get; set; }
        public bool AcceptKvkk { get; set; }
        public DateTime AgreementAcceptedAt { get; set; }
        public string AgreementAcceptedIp { get; set; }

    }
}
