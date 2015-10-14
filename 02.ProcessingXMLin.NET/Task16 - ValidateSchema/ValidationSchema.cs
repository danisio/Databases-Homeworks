namespace ValidateSchema
{
    using System;
    using System.Xml.Linq;
    using System.Xml.Schema;

    public class ValidationSchema
    {
        public static void Main(string[] args)
        {
            var schema = new XmlSchemaSet();
            schema.Add(string.Empty, "../../../files/catalog.xsd");

            var doc = XDocument.Load("../../../files/catalog.xml");
            var invalidDoc = XDocument.Load("../../../files/invalidCatalog.xml");

            ValidateSchema(doc, schema, "catalog.xml");
            ValidateSchema(invalidDoc, schema, "invalidCatalog.xml");
        }

        private static void ValidateSchema(XDocument doc, XmlSchemaSet schema, string file)
        {
            doc.Validate(schema, (o, e) =>
            {
                Console.WriteLine("Not valid schema in file \"{0}\"\nException: {1}", file, e.Message);
            });
        }
    }
}

