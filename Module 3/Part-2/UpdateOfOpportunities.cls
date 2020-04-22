public class UpdateOfOpportunities {
    public static void updateManagerToAccountInOpp(List<Opportunity> listOpportunity){
       Set<Id> opportunityIdSet = new Set<Id>();
       for(Opportunity opp : listOpportunity){
           if(opp.BillToContact__c != null && opp.Manager__c == null){
               opportunityIdSet.add(opp.id);
           }
       }
        system.debug('size   '+opportunityIdSet.size());
       if(opportunityIdSet.size() > 0){
           List<Opportunity> listOpportunityToUpdate = [SELECT BillToContact__r.AccountId,Manager__c FROM Opportunity WHERE id IN : opportunityIdSet];
           for(Opportunity objOpp : listOpportunityToUpdate){
               system.debug('account   '+objOpp.BillToContact__r.AccountId);
               objOpp.Manager__c = objOpp.BillToContact__r.AccountId;
           }
           update listOpportunityToUpdate;
       }
   }
}