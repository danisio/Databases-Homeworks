namespace StudentSystem.ConsoleClient
{
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using StudentSystem.Data;
    using StudentSystem.Data.Migrations;
    using StudentSystem.Models;

    public class Startup
    {
        public static void Main()
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<StudentSystemDbContext, Configuration>());

            var dbContext = new StudentSystemDbContext();

            using (dbContext)
            {
                var student = new Student()
                  {
                      FirstName = "Joe",
                      LastName = "Doe",
                      StudentNumber = "SN1234567"
                  };

                dbContext.Students.Add(student);
                dbContext.SaveChanges();

                var countStudents = dbContext.Students.Count();
                Console.WriteLine(countStudents);
            }
        }
    }
}
