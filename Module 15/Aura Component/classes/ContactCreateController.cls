public with sharing class ContactCreateController {
    
    // To Save
    @Auraenabled
    public static string createContact(Contact contObj){
        try {
            insert contObj;
            return contObj.LastName+'\'s Contact Created.'; 
        } catch(DmlException e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
    
    // To retrieve
    @Auraenabled
    public static List<Contact> retrieveContacts(){
        return [SELECT Id,FirstName,LastName,Email,Phone,Fax FROM Contact ORDER BY CreatedDate DESC LIMIT 20];
    }
}