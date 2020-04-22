global class OppOwnerMail implements Schedulable {
    global void execute(SchedulableContext ctx) {
        AggregateResult[] groupedResults = [Select Opportunity.owner.email from Opportunity where LastModifiedDate <  LAST_N_DAYS:10 group by Opportunity.owner.email];
        
        for (AggregateResult ar : groupedResults)  {
            System.debug('Average amount' + ar.get('expr0'));
            EmailManager.sendMail(ar.get('expr0')+'', 'Trailhead Tutorial', 'Please update');
        }
    }

}