namespace DomParser
{
    using System;
    using System.Collections.Generic;
    using System.Xml;
   
    public class DomParser
    {
        public static void Main(string[] args)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../files/catalog.xml");

            var root = xmlDoc.DocumentElement;
            
            var artistsList = new Dictionary<string, int>();

            foreach (XmlElement album in root.ChildNodes)
            {
                var artist = album["artist"].InnerText;

                if (artistsList.ContainsKey(artist))
                {
                    artistsList[artist]++;
                }
                else
                {
                    artistsList.Add(artist, 1);
                }
            }

            foreach (var item in artistsList)
            {
                Console.WriteLine("{0,20} - {1} albums", item.Key, item.Value);
            }
        }
    }
}
