namespace StudentSystem.Data.Migrations
{
    using System.Data.Entity.Migrations;
    using StudentSystem.Models;

    public sealed class Configuration : DbMigrationsConfiguration<StudentSystemDbContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationsEnabled = true;
            this.AutomaticMigrationDataLossAllowed = false;
            this.ContextKey = "StudentSystem.Data.StudentSystemDbContext";
        }

        protected override void Seed(StudentSystemDbContext context)
        {
            context.Courses.AddOrUpdate(c => c.Name,
                new Course { Name = "HQC" },
                new Course { Name = "Databases" });

            context.Students.AddOrUpdate(s => new { s.FirstName, s.LastName, s.StudentNumber },
                new Student { FirstName = "Ivaylo", LastName = "Kenov", StudentNumber = "SN54353463" },
                new Student { FirstName = "Niki", LastName = "Kostov", StudentNumber = "SN654654765" },
                new Student { FirstName = "Doncho", LastName = "Minkov", StudentNumber = "SN6575465" },
                new Student { FirstName = "Evlogi", LastName = "Hristov", StudentNumber = "SN5456547657" });
        }
    }
}