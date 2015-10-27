/*7. Try to open two different data contexts and perform concurrent changes on the same records.
What will happen at SaveChanges()?
How to deal with it?
 */
namespace Task7.TwoDbContexts
{
    using System;
    using System.Linq;
    using Task1.CreateDbContext;

    public class StartUp
    {
        //// To deal with this problem next time use Transactions
        public static void Main()
        {
            var db1 = new NorthwindEntities();
            var db2 = new NorthwindEntities();

            var employeeFromDb1 = db1.Employees.FirstOrDefault();
            var employeeFromDb2 = db2.Employees.FirstOrDefault();

            Console.WriteLine("Name from db1: {0}", employeeFromDb1.FirstName + " " + employeeFromDb1.LastName);
            Console.WriteLine("Name from db2: {0}", employeeFromDb2.FirstName + " " + employeeFromDb2.LastName);

            employeeFromDb1.LastName = "context 1";

            // Second name will overwrite the first.
            employeeFromDb2.LastName = "context 2";

            db1.SaveChanges();
            db2.SaveChanges();

            var dbResult = new NorthwindEntities().Employees.FirstOrDefault();
            Console.WriteLine("\nResult:      : {0}", dbResult.FirstName + " " + dbResult.LastName);
        }
    }
}