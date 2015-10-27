/* 6. Create an Excel file with 2 columns: name and score.
 Write a program that reads your MS Excel file through the OLE DB data provider and displays the name and score row by row.*/
namespace Task6
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
                OleDbCommand xslCommand = new OleDbCommand("SELECT * FROM [Sheet1$]", dbCon);
                OleDbDataReader reader = xslCommand.ExecuteReader();
                
                using (reader)
                {
                    while (reader.Read())
                    {
                        string name = (string)reader["Name"];
                        double score = (double)reader["Score"];
                        Console.WriteLine("Name: {0, -15} -> {1} points", name, score);
                    }
                }
            }
        }
    }
}
