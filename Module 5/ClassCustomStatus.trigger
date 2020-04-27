/**
 * Create a new PickList “Custom Status” in Class object.(New,Open,Close,Reset) values. When this
 * field changed and value is “Reset” now then delete all associated students with related Class.
 */

trigger ClassCustomStatus on Class__c (after update, before update) {
    
    // This is to update the NumberOfStudents__c field
    if(Trigger.isBefore){
        for(Class__c cls : Trigger.new){
            if(cls.Custom_Status__c == 'Reset'){
                // Set my count to zero because all students will geting deleted
                cls.MyCount__c = 0;
            }
        }
    }
    
    // this is to delete the releted students
    else{
        
        // classSet to store class id those who having reset
        Set<Id> classSet = new Set<Id>();

        for(Class__c cls : Trigger.new){
            // if Custom_Status__c field value is reset
            if(cls.Custom_Status__c == 'Reset'){
                classSet.add(cls.Id);
            }
        }
        // fetch list of related Student in this class
        List<student__C> studentList = [SELECT id FROM Student__c WHERE Class__c IN:classSet];
        Delete studentList;
    }
    
}