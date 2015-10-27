/*1. Using the Visual Studio Entity Framework designer create a DbContext for the Northwind database*/
namespace Task1.CreateDbContext
{
    using System;
    using System.Linq;

    public class Program
    {
        public static void Main()
        {
            using (var db = new NorthwindEntities())
            {
                var counter = 1;

                Console.WriteLine("Countries:");
                var countries = db.Employees.Select(c => c.Country).ToList();
                foreach (var c in countries)
                {
                    Console.WriteLine(counter++ + " " + c);
                }
            }
        }
    }
}
