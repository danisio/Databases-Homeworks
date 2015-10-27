////1. Write a program that retrieves from the Northwind sample database in MS SQL Server the number of rows in the Categories table.
namespace Task1
{
    using System;
    using System.Data.SqlClient;

    public class Program
    {
        public static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.; Database=Northwind; Integrated Security=true");
            dbCon.Open();

            using (dbCon)
            {
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM Categories", dbCon);

                int countOfRows = (int)command.ExecuteScalar();

                Console.WriteLine("Number of rows in the Categories table = {0}", countOfRows);
            }
        }
    }
}
