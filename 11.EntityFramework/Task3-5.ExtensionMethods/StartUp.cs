namespace Task3_5.ExtensionMethods
{
    using System;
    using Task1.CreateDbContext;

    public class StartUp
    {
        public static void Main()
        {
            var db = new NorthwindEntities();

            using (db)
            {
                Console.WriteLine("--------------------------Task3----------------------------");
                var counter = 1;
                var customers = ExtensionMethods.GetCustomersWithSpecificOrders(db, 1997, "Canada");
                foreach (var c in customers)
                {
                    Console.WriteLine(counter++ + " " + c);
                }

                Console.WriteLine();
                Console.WriteLine("--------------------------Task4----------------------------");
                counter = 1;
                var customersNative = ExtensionMethods.GetCustomersWithSpecificOrdersNativeSQL(db, 1997, "Canada");
                foreach (var c in customersNative)
                {
                    Console.WriteLine(counter++ + " " + c);
                }

                Console.WriteLine();
                Console.WriteLine("--------------------------Task5----------------------------");
                counter = 1;
                var orders = ExtensionMethods.GetSalesByRegionAndPeriod(db, "SP", new DateTime(1998, 01, 01), DateTime.Now);
                foreach (var order in orders)
                {
                    Console.WriteLine(counter++ + " " + order);
                }
            }
        }
    }
}
