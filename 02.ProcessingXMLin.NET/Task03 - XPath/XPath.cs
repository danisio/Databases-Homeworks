namespace XPath
{
    using System;
    using System.Collections.Generic;
    using System.Xml;

    public class XPath
    {
        public static void Main(string[] args)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../files/catalog.xml");

            string xPathQuery = "/catalog/album/artist";
            XmlNodeList artistsNodes = xmlDoc.SelectNodes(xPathQuery);

            var artistsList = new Dictionary<string, int>();
            
            foreach (XmlNode artist in artistsNodes)
            {
                var art = artist.InnerText;

                if (artistsList.ContainsKey(art))
                {
                    artistsList[art]++;
                }
                else
                {
                    artistsList.Add(art, 1);
                }
            }

            foreach (var item in artistsList)
            {
                Console.WriteLine("{0,20} - {1} albums", item.Key, item.Value);
            }
        }
    }
}
