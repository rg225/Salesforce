/**
 * Not allow any class to delete if there are more than one Female students.
 */

trigger ClassDeletion on Class__c (before delete) {
    
    // Query to select class id and number of girls in that class using group by
    AggregateResult[] groupedResults = [SELECT class__r.id classId, count(id) numberOfGirls FROM Student__c WHERE Sex__c = 'Female' AND Class__c IN:trigger.old GROUP BY class__r.id];

    // Using for loop check that is there more then 1 girls
    // Throw an error if there are more than one girls exist
    for (AggregateResult ar : groupedResults)  {
        if(integer.valueof(ar.get('numberOfGirls')) > 1){
            ID clsId = ar.get('classId').toString();
            Trigger.oldMap.get(clsId).addError('Cannot delete Class because in this class more than 1 girls exist.');
        }
    }
}