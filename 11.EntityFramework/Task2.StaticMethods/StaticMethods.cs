namespace Task2.StaticMethods
{
    using System;
    using System.Linq;

    using Task1.CreateDbContext;

    public static class StaticMethods
    {
        public static string InsertNewCustomer(NorthwindEntities db, Customer customer)
        {
            if (customer == null)
            {
                throw new ArgumentNullException("Customer cannot be null.");
            }

            using (db)
            {
                db.Customers.Add(customer);
                db.Customers.Add(customer);
                db.SaveChanges();

                return customer.CustomerID;
            }
        }

        public static void UpdateCustomerCompanyName(NorthwindEntities db, string customerID, string newCompanyName)
        {
            if (string.IsNullOrWhiteSpace(customerID))
            {
                throw new ArgumentException(string.Format("Invalid ID : {0}.", customerID));
            }
            
            using (db)
            {
                var customer = db.Customers
                                .FirstOrDefault(c => c.CustomerID == customerID);

                if (customer == null)
                {
                    throw new ArgumentException("No such customer with this id.");
                }

                customer.CompanyName = newCompanyName;
                db.SaveChanges();
            }
        }

        public static void Delete(NorthwindEntities db, string customerID)
        {
            if (string.IsNullOrWhiteSpace(customerID))
            {
                throw new ArgumentException("Id is null, empty or contains only whitespaces.");
            }

            using (db)
            {
                var customer = db.Customers
                                .FirstOrDefault(c => c.CustomerID == customerID);

                if (customer == null)
                {
                    throw new ArgumentException("No such customer with this id.");
                }

                db.Customers.Remove(customer);
                db.SaveChanges();
            }
        }
    }
}
