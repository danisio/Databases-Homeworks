namespace Transform
{
    using System;
    using System.Xml.Xsl;

    public class Transform
    {
        public static void Main(string[] args)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load("../../../files/catalog.xslt");
            xslt.Transform("../../../files/catalog.xml", "../../../files/catalog.html");

            Console.WriteLine("Done");
        }
    }
}
