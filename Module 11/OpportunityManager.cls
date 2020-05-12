public with sharing class OpportunityManager {
	
        // to send a mail when stage of opportunity is updated
        public static void handleStatusUpdate(Map<Id,Opportunity> newOpportunityMap, Map<Id,Opportunity> oldOpportunityMap){
            for(Opportunity oppRecord : newOpportunityMap.values()){
                
                // check stage is change
                if(oppRecord.StageName != oldOpportunityMap.get(oppRecord.Id).StageName){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] {oppRecord.OwnerId};
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Opportunity stage changed : ' + oppRecord.StageName);
                    mail.setPlainTextBody('Your Oppportunity: ' + oppRecord.Name +' has been updated from ' +
                                          oldOpportunityMap.get(oppRecord.Id).StageName +' to ' + oppRecord.StageName);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                }
            }
        }
    }