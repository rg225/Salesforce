// To convert xml body to list of contact
public class XmlParse{
    
    // it will take xml body as an argument and return a list of contact
    public static List<Contact> parseXml(String xmlBody){
     
     // Creates a new instance of the Dom.Document class.
       Dom.Document doc = new Dom.Document();
     
     // Parse the XML representation of the document specified in the xml argument and load it into a document.
       doc.load(xmlbody);
     
     // to get top-level root element node in the document.
       Dom.XMLNode rootOfContacts = doc.getRootElement();
     
     // list to store contact from document
       List<Contact> contacts = new List<Contact>();
     
     // to fetch child elements
       List<Dom.XMLNode> contactRecordList = rootOfContacts.getChildElements();
       for(Dom.XmlNode contactRecord : contactRecordList){
           String firstName = contactRecord.getChildElement('fname',null).getText(); // text inside <fname> field
           String lastName = contactRecord.getChildElement('lname',null).getText();
           String mailingCity = contactRecord.getChildElement('mailingCity',null).getText();
           String mailingState = contactRecord.getChildElement('mailingState',null).getText();
           String mailingCountry = contactRecord.getChildElement('mailingCountry',null).getText();
           System.debug('fname : ' + firstName + '  lname : '+ lastName);
           Contact con = new Contact( FirstName = firstName, LastName = lastName , MailingCity = mailingCity , MailingState = mailingState , MailingCountry = mailingCountry);
           contacts.add(con);
       }
       return contacts;
   }
}
