using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services.DTOs
{
        public class UserDto
        {
            public int Id { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string FullName { get; set; }
            public string Avatar { get; set; }
            public string Email { get; set; }
            public string PasswordHash { get; set; }
            public string PhoneNumber { get; set; }
            public DateTime? BirthDate { get; set; }
            public bool IsActive { get; set; }
            public int RoleId { get; set; }
            public string RoleName { get; set; }
            public bool AcceptMembershipAgreement { get; set; }
            public bool AcceptKvkk { get; set; }
            public string AgreementAcceptedIp { get; set; }
            public bool IsEmailConfirmed { get; set; }
            public string EmailConfirmCode { get; set; }
            public DateTime? EmailConfirmCodeExpire { get; set; }
            public int EmailConfirmAttemptCount { get; set; }
            public DateTime? EmailConfirmLastSentAt { get; set; }
            public string ResetPasswordToken { get; set; }
            public DateTime? ResetPasswordTokenExpire { get; set; }
            public string RememberMeToken { get; set; }
            public DateTime? RememberMeExpire { get; set; }
    }


}
