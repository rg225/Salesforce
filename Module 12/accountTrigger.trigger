// 1: Saperate SOQL is written for the close lost and close won
// 2: Query Syntex is in lower case
// 3: Nested loop is used and even no need to add outer loop

trigger accountTrigger on Account (before delete, before insert, before update) {
    
    // SOQL to find records related to the stage name as close lost or close won
	List<Opportunity> opp = [SELECT Id, Name, CloseDate, StageName FROM Opportunity WHERE 
                             AccountId IN : Trigger.newMap.keySet() AND (StageName = 'Closed - Lost' OR StageName = 'Closed - Won') ];
	
    // Iterate the list of opportunity 
    for(Opportunity o: opp){
        
        // if stage is closed - won
        if(o.StageName == 'Closed - Won'){
            System.debug('Do more logic here...');
        }
        // if stage is closed - lost
        else{
            System.debug('Do more logic here...');
        }
    }
}