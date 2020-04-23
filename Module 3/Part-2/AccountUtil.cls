/**
 * One custom field in Account object (ContactIDs), it would have comma separated list of all
*  related Contact IDs. Create a class and a static function which takes a ContactID as argument and
*  check if Account’s ContactIDs field is Null or Not Null
*  -IF Null, then fetch all related Account Contacts and store their IDs as a comma separated list in it.
*  -IF Not Null, then check, Is ContactID already exist in the field value, if not then append it on that
*   value.
 */


public class AccountUtil {
    /**
     * a static function which takes a ContactID as argument and check if Account’s ContactIDs field and
     * store them in the account ContactIDs field
     */
	public static void storeContactIds(Id contactId){
    	Contact contact = [SELECT accountid FROM Contact WHERE id =: contactId];
        Account accountContactIds = [SELECT id, ContactIDs__c FROM account WHERE id =: contact.AccountId];
        
        // If Contactid field of account is null
        if (accountContactIds.ContactIDs__c == null){
            
            // Fetch all contact id related to that account
            List<Contact> contactIdList = [SELECT id FROM contact WHERE accountid =: accountContactIds.id];
           
            String newContactIds = '';
            
            // Concate them in the newContactIds variable using ',' operator
            for(Contact cntObj : contactIdList){
                newContactIds += cntObj.id + ',';
            }

            // To remove the extra comma at the end of newContactIds variable
            accountContactIds.ContactIDs__c = newContactIds.removeEnd(',');
        }
        // If Contactid field of account is not null
        else
            // To check whether this id is exist or not in the account's contactids field
            // if not then add it in that using ',' opearator
            if (!(accountContactIds.ContactIDs__c.contains(contactId))){
                accountContactIds.ContactIDs__c += ',' + contactId;
            }
        // update operation
        update accountContactIds;
    }
}