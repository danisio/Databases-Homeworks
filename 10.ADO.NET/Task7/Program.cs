/* 7. Implement appending new rows to the Excel file.*/
namespace Task7
{
    using System;
    using System.Data.OleDb;

    public class Program
    {
        public static void Main()
        {
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0; Data Source=..\..\files\data.xlsx;Extended Properties='Excel 12.0 Xml;HDR=YES/';";

            OleDbConnection dbCon = new OleDbConnection(connectionString);
            dbCon.Open();

            using (dbCon)
            {
                AddNewRow(dbCon, "Ivailo Kenov", 22);
                AddNewRow(dbCon, "Evlogi Hristov", 5);
            }
        }

        private static void AddNewRow(OleDbConnection dbConnection, string name, double score)
        {
            OleDbCommand commandd = new OleDbCommand(
               string.Format("INSERT INTO [Sheet1$] (Name, Score) VALUES ('{0}', '{1}')", name, score), 
               dbConnection);

            try
            {
                commandd.ExecuteNonQuery();
                Console.WriteLine("Successfuly added!");
            }
            catch (OleDbException exception)
            {
                Console.WriteLine("Cannot insert the new row. " + exception);
            }
        }
    }
}
