/**
 * In Opportunity, If the stage is changed from another value to CLOSED_WON or CLOSED_LOST,
 * populates the Close Date field with Today().
 */

trigger StageOfOpportunity on Opportunity (before update) {

    // to traverse the bulky update
    for(Opportunity opp : Trigger.new){

        if(opp.StageName == 'CLOSED WON' || opp.StageName == 'CLOSED LOST'){

            // get past value
            Opportunity oldOpp = trigger.oldMap.get(opp.Id);

            // check that it's old value was not relate with CLOSED WON and CLOSED LOST
            if(!(oldOpp.StageName == 'CLOSED WON' || oldOpp.StageName == 'CLOSED LOST')){
                opp.CloseDate = date.today(); 
            }
        }
    }
}