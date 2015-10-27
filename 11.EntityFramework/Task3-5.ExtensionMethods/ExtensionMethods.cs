namespace Task3_5.ExtensionMethods
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    using Task1.CreateDbContext;

    public class ExtensionMethods
    {
        //// 3. Write a method that finds all customers who have orders made in 1997 and shipped to Canada.
        public static IEnumerable<object> GetCustomersWithSpecificOrders(NorthwindEntities db, int year = 1997, string country = "Canada")
        {
            var result = db.Orders
                .Where(o => o.ShippedDate.Value.Year == year && o.ShipCountry == country)
                .Select(c => new
                {
                    c.Customer.CompanyName,
                    c.Customer.ContactName
                })
                .Distinct()
                .ToList();

            return result;
        }

        //// 4. Implement previous by using native SQL query and executing it through the DbContext.
        public static IEnumerable<object> GetCustomersWithSpecificOrdersNativeSQL(NorthwindEntities db, int year = 1997, string country = "Canada")
        {
            string queryString =
                "SELECT DISTINCT c.CompanyName, c.ContactName " +
                "FROM Customers c " +
                    "JOIN Orders o " +
                    "ON c.CustomerID = o.CustomerID " +
                "WHERE YEAR(o.ShippedDate) = " + year + " AND o.ShipCountry = '" + country + "'";

            var result = db.Database.SqlQuery<CustomerInfo>(queryString).ToList();

            return result;
        }

        //// 5. Write a method that finds all the sales by specified region and period (start / end dates).
        public static IEnumerable<object> GetSalesByRegionAndPeriod(NorthwindEntities db, string region, DateTime startDate, DateTime endDate)
        {
            var orders = db.Orders
                .Where(o =>
                    o.ShipRegion == region &&
                    o.OrderDate > startDate &&
                    o.OrderDate < endDate)
                 .Select(o => new
                 {
                     o.OrderID,
                     o.OrderDate,
                     o.ShipName
                 })
                .ToList();

            return orders;
        }
    }
}
