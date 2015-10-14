namespace XDocumentLINQ
{
    using System;
    using System.Linq;
    using System.Xml.Linq;

    public class XDocumentLINQ
    {
        public static void Main(string[] args)
        {
            XDocument xmlDoc = XDocument.Load("../../../files/catalog.xml");

            var songs =
                from song in xmlDoc.Descendants("song")
                select song.Element("title").Value;

            Console.WriteLine("List of all songs in the catalog:");
            int count = 0;

            foreach (var song in songs)
            {
                count++;
                Console.WriteLine("{0,3}. {1}", count, song);
            }
        }
    }
}
