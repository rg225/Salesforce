@isTest
public class TestAccountUtil {

    // Test when contactId of account field is null
    @isTest
    static void TestAccountWhenContactIdFieldIsNull(){
        
        // Create data to test
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Gupta', AccountId = acct.Id);
        insert cont;
        
        // Use static method to test
        AccountUtil.storeContactIds(cont.Id);
        
        // Fetch contactIds field from that 
        Account act = [SELECT ContactIds__c FROM Account WHERE Id =: acct.Id];
        
        // Compare the ecpected and actual 
        System.assertEquals(string.valueOf(cont.Id), act.ContactIds__c);
    } 
    
    // Test when contactId of account field is not null
    @isTest
    static void TestAccountWhenContactIdFieldIsNotNull(){
        
        // Create data to test
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont1 = new Contact(LastName = 'Gupta', AccountId = acct.Id);
        insert cont1;
        
        // This is for not null so first we store cont1 id in the contactIds field
        acct.ContactIDs__c = cont1.Id;
        update acct;
        
		// Then pass cont2 id in the function
        Contact cont2 = new Contact(LastName = 'Gupta', AccountId = acct.Id);
        insert cont2;
        
        // Use static method to test
        AccountUtil.storeContactIds(cont2.Id);
        
        // Fetch contactIds field from that 
        Account act = [SELECT ContactIds__c FROM Account WHERE Id =: acct.Id];
        
        // Compare the ecpected and actual 
        String allContactIds = cont1.Id +','+ cont2.Id ;
        System.assertEquals(allContactIds, act.ContactIds__c);
    } 
}