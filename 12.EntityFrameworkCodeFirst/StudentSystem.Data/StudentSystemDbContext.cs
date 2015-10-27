namespace StudentSystem.Data
{
    using System.Data.Entity;
    using StudentSystem.Models;
	
    public class StudentSystemDbContext : DbContext
    {
        public StudentSystemDbContext()
            :base("StudentSystem")
        {
        }
        public IDbSet<Course> Courses { get; set; }

        public IDbSet<Student> Students { get; set; }

        public IDbSet<Homework> Homeworks { get; set; }
    }
}
