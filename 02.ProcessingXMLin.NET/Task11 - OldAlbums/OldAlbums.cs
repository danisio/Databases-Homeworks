namespace OldAlbums
{
    using System;
    using System.Xml;

    public class OldAlbums
    {
        public static void Main(string[] args)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../files/catalog.xml");

            string xPathQuery = "/catalog/album[year<=2010]";
            XmlNodeList albums = xmlDoc.SelectNodes(xPathQuery);

            foreach (XmlElement album in albums)
            {
                Console.WriteLine("Year {0} - Price: {1}", album["year"].InnerText, album["price"].InnerText);
            }
        }
    }
}
