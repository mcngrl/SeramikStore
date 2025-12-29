using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text.RegularExpressions;

public class TurkishDecimalAttribute : ValidationAttribute
{

    private static readonly Regex _regex =
      new Regex(@"^(\d{1,3}(\.\d{3})*|\d+)(,\d{1,2})?$");
    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        if (value == null)
            return ValidationResult.Success;

        var strValue = value.ToString();

        if (string.IsNullOrWhiteSpace(strValue))
            return ValidationResult.Success;

        // 1️⃣ FORMAT KONTROLÜ
        if (!_regex.IsMatch(strValue))
        {
            return new ValidationResult("Geçerli bir fiyat giriniz. Örn: 1.250,67");
        }

        // 2️⃣ PARSE
        var normalized = strValue.Replace(".", "").Replace(",", ".");

        if (!decimal.TryParse(normalized, NumberStyles.Number, CultureInfo.InvariantCulture, out _))
        {
            return new ValidationResult("Geçerli bir fiyat giriniz. Örn: 1.250,67");
        }

        return ValidationResult.Success;
    }
}
