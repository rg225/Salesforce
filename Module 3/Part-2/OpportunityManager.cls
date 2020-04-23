public class OpportunityManager {
    /**
     * function to Update the Opportunities 
     * param List<Opportunity> and check if BillToContact field is not Blank and Manager is
     * Blank then populate Manager field by related account which is linked with the contact 
     * given in BillToContact field..
     */
    public static void updateManagerToAccountInOpp(List<Opportunity> listOpportunity){
       Set<Id> opportunityIdSet = new Set<Id>();

       // loop to check fiels of billtocontract and manager
       for(Opportunity opp : listOpportunity){
           if(opp.BillToContact__c != null && opp.Manager__c == null){
               opportunityIdSet.add(opp.id);
           }
       }
       // Do operation if conditon matches for any user
       if(opportunityIdSet.size() > 0){

            // list of opportunitys those who satisafy the null condition for the billcontract and manager
           List<Opportunity> listOpportunityToUpdate = [SELECT BillToContact__r.AccountId,Manager__c FROM Opportunity WHERE id IN : opportunityIdSet];
           
           // Update the value of manager with Account field id
           for(Opportunity objOpp : listOpportunityToUpdate){
               objOpp.Manager__c = objOpp.BillToContact__r.AccountId;
           }
           update listOpportunityToUpdate;
       }
   }
}