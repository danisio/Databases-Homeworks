namespace DeleteAlbums
{
    using System;
    using System.Xml;

    public class DeleteAlbums
    {
        public static void Main(string[] args)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../files/catalog.xml");

            var root = xmlDoc.DocumentElement;

            foreach (XmlNode album in root.SelectNodes("album"))
            {
                var priceStr = album["price"].InnerText.Substring(1);
                var priceDouble = double.Parse(priceStr);

                if (priceDouble > 20)
                {
                    root.RemoveChild(album);
                }
            }

            xmlDoc.Save("../../../files/cheapCatalog.xml");
            Console.WriteLine("Expensive albums have been removed.");
        }
    }
}
