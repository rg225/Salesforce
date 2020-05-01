@isTest
public class TestOpportunityManager {

    // Test when BillToContact__c field is not null and manager fiels is null 
    @isTest
    static void TestOpportunityManagerPositiveCase(){
        
        // Create test data
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Gupta', AccountId = acct.Id);
        insert cont;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < 10; i++){
            Opportunity opp = new Opportunity(Name = 'Name' + i, CloseDate = system.Date.today(), StageName = 'Closed Won',
                                            BillToContact__c = cont.Id);
            opps.add(opp);
        }
        insert opps;
        
        // use function to test by passing opportunity list
        OpportunityManager.updateManagerToAccountInOpp(opps);
        
        // Compare the manage field of all opportunity
        List<Opportunity> oppList = [SELECT Manager__c FROM Opportunity];
        for(Integer i = 0; i < 10; i++){
            system.assertEquals(acct.Id, oppList[i].Manager__c);
        }
    }
    
    // Test when BillToContact__c field is null and manager fiels is also null 
    @isTest
    static void TestOpportunityManagerNegativeCase(){
        
        // Create test data
        Account acct = new Account(Name = 'Test Account');
        insert acct;
        Contact cont = new Contact(LastName = 'Gupta', AccountId = acct.Id);
        insert cont;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < 10; i++){
            Opportunity opp = new Opportunity(Name = 'Name' + i, CloseDate = system.Date.today(), StageName = 'Closed Won');
            opps.add(opp);
        }
        insert opps;
        
        // use function to test by passing opportunity list
        OpportunityManager.updateManagerToAccountInOpp(opps);
        
        // Compare the manage field of all opportunity
        // Manage field will not updated
        List<Opportunity> oppList = [SELECT Manager__c FROM Opportunity];
        for(Integer i = 0; i < 10; i++){
            system.assertEquals(null, oppList[i].Manager__c);
        }
    }
}