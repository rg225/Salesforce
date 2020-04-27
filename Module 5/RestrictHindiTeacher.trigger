/**
 * Not Allow any teacher to insert/update if that teacher is teaching Hindi 
 */

trigger RestrictHindiTeacher on Teach__c(before insert, before update) {

    // to check, is new record created
    if(Trigger.IsInsert){
        for(Teach__c teach : Trigger.new){

            // Check, is subject hindi? to restrict
            if(teach.Subject__c.contains('Hindi')){
                teach.Subject__c.addError('Sorry Hindi teachers can not create the account');
            }
        }
    }
    // to check, is old record updated
    else {

        // to traverse the old trigger because addError not work with that
        Integer index = 0;
        for(Teach__c teach : Trigger.new){
            
            // Check that subject is hindi or not to restrict (check new and old both)
            if(Trigger.old[index].Subject__c.contains('Hindi') || teach.Subject__c.contains('Hindi')){
                teach.Subject__c.addError('Sorry Hindi teachers can not Update the account'); 
            }
            index++;
        }
    }
}