

using System;

namespace SeramikStore.Contracts.Cart
{
    public class StockCheckResult
    {
        public bool IsSuccess { get; set; }
        public string ErrorCode { get; set; }
        public string Message { get; set; }
        public int? CartId { get; set; }
        public int? ProductId { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public int? CartQuantity { get; set; }
        public int? StockAmount { get; set; }
    }
}

