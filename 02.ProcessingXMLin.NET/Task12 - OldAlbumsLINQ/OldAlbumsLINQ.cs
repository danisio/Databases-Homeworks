namespace OldAlbumsLINQ
{
    using System;
    using System.Linq;
    using System.Xml.Linq;

    public class OldAlbumsLINQ
    {
        public static void Main(string[] args)
        {
            XDocument xmlDoc = XDocument.Load("../../../files/catalog.xml");

            var albums =
                from album in xmlDoc.Descendants("album")
                where int.Parse(album.Element("year").Value) <= 2010
                select new
                {
                    year = album.Element("year").Value,
                    price = album.Element("price").Value
                };

            foreach (var item in albums)
            {
                Console.WriteLine("Year {0} - {1}", item.year, item.price);
            }
        }
    }
}
