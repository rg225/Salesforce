public class AddContactIdsToAccount {
	public static void getContactId(Id contactId){
    	Contact contact = [SELECT accountid from Contact where id =: contactId];
    	Account accountContactIds = [SELECT id, ContactIDs__c FROM account where id =: contact.AccountId];
        if (accountContactIds.ContactIDs__c == null){
            List<Contact> contactIdList = [SELECT id from contact where accountid =: accountContactIds.id];
            String newContactIds = '';
            for(Contact cntObj : contactIdList){
                newContactIds += cntObj.id + ',';
            }
            accountContactIds.ContactIDs__c = newContactIds.removeEnd(',');
        }
        else
            if (!(accountContactIds.ContactIDs__c.contains(contactId))){
                accountContactIds.ContactIDs__c += ',' + contactId;
            }
        
        update accountContactIds;
    }
}