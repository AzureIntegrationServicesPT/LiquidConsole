// using System.Collections.Generic;
// using com.siemens.spice.confluent.model;

// namespace com.siemens.spice.confluent.model.base{
//     public class AttachmentData
//     {
//         public string name { get; set; }
//         public string key { get; set; }
//     }

//     public class ClmData
//     {
//         public string cin { get; set; }
//         public IEnumerable<> attachments { get; set; }
//     }

//     public class CompanyData
//     {
//         public string company { get; set; }
//         public string department { get; set; }
//         public string city { get; set; }
//         public string postCode { get; set; }
//         public string street { get; set; }
//         public string streetNo { get; set; }
//         public string country { get; set; }
//         public string vatNo { get; set; }
//         public string ifaNo { get; set; }
//         public string debitorNo { get; set; }
//     }

//     public class ContactData
//     {
//         public string lastName { get; set; }
//         public string firstName { get; set; }
//         public string email { get; set; }
//         public string phoneNo { get; set; }
//         public string department { get; set; }
//         public string mobileNo { get; set; }
//     }

//     public class CustomerData
//     {
//         publicbase.CompanyDatacustomerCompany { get; set; }
//         publicbase.ContactDatacustomerContact { get; set; }
//         publicbase.CompanyDataendCustomer { get; set; }
//     }

//     public class RfqItemData
//     {
//         public string articleNo { get; set; }
//         public string remarks { get; set; }
//         public int? quantity { get; set; }
//     }
// }

// namespace com.siemens.spice.confluent.model.rfq
// {
//     public class RfqMessageData
//     {
//         public string sourceSystem { get; set; }
//         public string country { get; set; }
//         public string language { get; set; }
//         public string qlmQuoteId { get; set; }
//         public string rfqRemarks { get; set; }
//         public base.ClmDataclm { get; set; }
//         public CustomerData CustomerDatacustomerData { get; set; }
//         public IEnumerable<> rfqItems { get; set; }
//     }
// }
