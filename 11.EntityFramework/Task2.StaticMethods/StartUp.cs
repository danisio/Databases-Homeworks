/*2. Create a DAO class with static methods which provide functionality for inserting, modifying and deleting customers.*/
namespace Task2.StaticMethods
{
    using Task1.CreateDbContext;

    public class StartUp
    {
        public static void Main()
        {
            var db = new NorthwindEntities();
        }
    }
}
