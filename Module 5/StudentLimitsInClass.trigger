/**
 * Not allow insert student if class already reached MaxLimit.(Without using MyConnt field).
 * When insert/update any student’s in class then update MyCount Accordingly(Use MyCount as anumber field).
 */

trigger StudentLimitsInClass on Student__c (before insert, before update) {

    // map to store class id and counting of new students 
    Map<Id, Integer> classAndSizeMap = new Map<Id, Integer>();

    for(Student__c newStudent : Trigger.new){

        // check whether this classis exist or not
        if(!classAndSizeMap.containsKey(newStudent.Class__c)){

            // add class id with count 1 because now we will increase in else part
            classAndSizeMap.put(newStudent.Class__c,1);
        }
        else{

            // id already exist so update the count value
            Integer count  = classAndSizeMap.get(newStudent.Class__c)+1;
            classAndSizeMap.put(newStudent.Class__r.id,count);
        }
    }

    // get how many students already exist in that class
    AggregateResult[] student = [SELECT Class__r.Id classId, COUNT(Id) numberOfStudent FROM Student__c WHERE Class__r.Id IN: classAndSizeMap.keySet() GROUP BY Class__r.Id];
    
    // Add all these studnets numbers in the map with new numbers of new students
    for(AggregateResult ar : student){
        Id clsId = ar.get('classId').toString();
        Integer count  = classAndSizeMap.get(clsId) + integer.valueof(ar.get('numberOfStudent'));
        classAndSizeMap.put(clsId,count);
    }
    
    // get the id, maxSize and number of current students in the class  
    List<class__c> classInfoList = [SELECT Id, MaxSize__c, MyCount__c FROM Class__c WHERE Id IN : classAndSizeMap.keySet()];
    
    // to check that with new students, maxSize of class is exceed or not
    for (Class__c classInfo : classInfoList) {
        if(classAndSizeMap.get(classInfo.Id) > classInfo.MaxSize__c ){
            // class will exceed the size so dispaly an error
            Trigger.new[0].addError('Sorry you can not add more students in this class');
        }
        else{
            // if not exceed than update the count with map value which is (Currnt + Old)
            classInfo.MyCount__c = classAndSizeMap.get(classInfo.Id);
        }
    }
    update classInfoList; 
}