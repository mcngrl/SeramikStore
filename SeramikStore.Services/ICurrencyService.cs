using SeramikStore.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeramikStore.Services
{
    public interface ICurrencyService
    {
        List<Currency> CurrencyList();
        Currency GetDefaultCurrency();
        void InsertCurrency(Currency currency);
        void UpdateCurrency(Currency currency);
        void DeleteCurrency(int currencyId);
    }
}
