/**
 * Not allow insert student if class already reached MaxLimit.(Without using MyConnt field).
 * When insert/update any student’s in class then update MyCount Accordingly(Use MyCount as anumber field).
 */

trigger StudentLimitsInClass on Student__c (before insert, before update) {

    // map to store class id and counting of new students 
    Map<Id, Integer> classAndSizeMap = new Map<Id, Integer>();

    for(Student__c newStudent : Trigger.new){

        // check whether this classis exist or not
        if(!classAndSizeMap.containsKey(newStudent.class__c)){

            // add class id with count 1 because now we will increase in else part
            classAndSizeMap.put(newStudent.class__c,1);
        }
        else{

            // id already exist so update the count value
            Integer count  = classAndSizeMap.get(newStudent.class__c)+1;
            classAndSizeMap.put(newStudent.class__r.id,count);
        }
    }

    // get how many students already exist in that class
    AggregateResult[] stu = [SELECT class__r.id classId, count(id) numberOfStudent FROM Student__C WHERE class__r.id IN: classAndSizeMap.keySet() GROUP BY class__r.id];
    
    // Add all these studnets numbers in the map with new numbers of new students
    for(AggregateResult ar : stu){
        Id idd = ar.get('classId').toString();
        Integer count  = classAndSizeMap.get(idd) + integer.valueof(ar.get('numberOfStudent'));
        classAndSizeMap.put(idd,count);
    }
    
    // get the id, maxSize and number of current studnts in the class  
    list<class__c> classInfoList = [SELECT id, MaxSize__c, myCount__c FROM class__c WHERE id IN : classAndSizeMap.keySet()];
    
    // to check that with new students, maxSize of class is exceed or not
    for (Class__C classInfo : classInfoList) {
        if(classAndSizeMap.get(classInfo.id) > classInfo.MaxSize__c ){
            // class will exceed the size so dispaly an error
            Trigger.new[0].addError('Sorry you can not add more students in this class');
        }
        else{
            // if not exceed than update the count with map value which is (Currnt + Old)
            classInfo.myCount__c = classAndSizeMap.get(classInfo.id);
        }
    }
    update classInfoList; 
}