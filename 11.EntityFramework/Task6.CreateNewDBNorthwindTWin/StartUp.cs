/*6. Create a database called NorthwindTwin with the same structure as Northwind using the features from DbContext.*/
namespace Task6.CreateNewDBNorthwindTWin
{
    using System;
    using Task1.CreateDbContext;

    public class StartUp
    {
        public static void Main()
        {
            using (var db = new NorthwindEntities())
            {
                var isCreated = db.Database.CreateIfNotExists();
                Console.WriteLine("DB is {0} created. ", isCreated ? "successfully" : "NOT");
            }
        }
    }
}
