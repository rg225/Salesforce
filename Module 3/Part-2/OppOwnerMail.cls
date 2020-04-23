global class OppOwnerMail implements Schedulable {
    // To schedule the function
    global void execute(SchedulableContext ctx) {

        // get array of owners for records those are not modified in the last 10 days
        AggregateResult[] groupedResults = [SELECT owner.email email FROM Opportunity WHERE LastModifiedDate <  LAST_N_DAYS:10 GROUP BY owner.email];
        
        // to send the mail to all those owners using loop
        for (AggregateResult ar : groupedResults)  {

            String eml = String.valueOf(ar.get('email'));

            // send mail function is defined in the EmailManager class
            EmailManager.sendMail(eml, 'Trailhead Tutorial', 'Please update the Opportunity');
        }
    }

    // Other Approach 
    public static void updateMailToOwner(){
        // Create a set because set store unique elements
        Set<String> uniqueOwners = new Set<String>();

        // list of opportunity those are not modified in the last 10 days with owner mail field
        List<Opportunity> listOfOwners = [Select owner.email from Opportunity where LastModifiedDate <  LAST_N_DAYS:10 ];
        
        // Store the unique emails in the set
        for(Opportunity own : listOfOwners){
            uniqueOwners.add(String.valueOf(own.owner.email));
        }
        // To print the unique emails
        for(String owner : uniqueOwners){
            system.debug(owner);
        }
    }

}