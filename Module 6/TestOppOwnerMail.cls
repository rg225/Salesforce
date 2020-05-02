@isTest
private class TestOppOwnerMail {
    // Dummy CRON expression: midnight on March 15.
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void testOpportunityOwnerMail() {
        // Create some out of date Opportunity records
        List<Opportunity> opptys = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i = 0; i < 10; i++) {
            Opportunity o = new Opportunity(
                Name = 'Opportunity ' + i,
                CloseDate = closeDate,
                StageName = 'Prospecting'
            );
            opptys.add(o);
        }
        insert opptys;
        
        // Test Start 
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new OppOwnerMail()); 
        System.assertEquals(1, Limits.getEmailInvocations());
        Test.stopTest();
        
    }
}