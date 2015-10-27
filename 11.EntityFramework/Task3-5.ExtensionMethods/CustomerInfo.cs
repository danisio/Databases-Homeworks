namespace Task3_5.ExtensionMethods
{
    public class CustomerInfo
    {
        public string CompanyName { get; set; }

        public string ContactName { get; set; }

        public override string ToString()
        {
            return string.Format("Company: {0} -- Contact name: {1}", this.CompanyName, this.ContactName);
        }
    }
}
