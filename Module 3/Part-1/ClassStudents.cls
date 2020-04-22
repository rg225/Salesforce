public class ClassStudents {
    public static List<Student__c> getAllSttudents(String classId){
        List<Student__c> listOfStudent = [SELECT Name FROM Student__c WHERE Class__r.Name=:classId];
        return listOfStudent;
    }
    public static map<String, Set<Id>> getMapOfStudents(){
        List<Class__c> className = [SELECT Name, (SELECT Id FROM Students__r) FROM Class__c];
        Map<String, Set<Id>> m = new Map<String, Set<Id>>();
        for(Class__c c : className){
            Set<Id> idSet = new Set<Id>();
            for(Student__c s : c.Students__r){
                idSet.add(s.id);
            }
            m.put(c.Name,idSet);            
        }
        return m;
    }
    public static Integer workingDays(Date startDate, Date lastDate){
        Integer workDays = startDate.daysBetween(lastDate) - 1;
        
        Datetime start = DateTime.newInstance(startDate, Time.newInstance(0, 0, 0, 0));
		String startDay=start.format('EEEE');
        
        Datetime last = DateTime.newInstance(lastDate, Time.newInstance(0, 0, 0, 0));
		String lastDay=last.format('EEEE');
        
        if(startDay=='Saturday'){
            workDays -= 1;
        }
        if(startDay=='Friday'){
            workDays -= 2;
        }
        if(lastDay=='Sunday'){
            workDays -= 1;
        }
        if(lastDay=='Monday'){
            workDays -= 2;
        }
        Integer days = (workDays/7);
        days = days*2;
        Return workDays-days;
    }
    public static void getMapOfStudentsd(){
        List<Class__c> className = [SELECT Name, (SELECT Id, Name FROM Students__r) FROM Class__c];
        Map<String, List<ID>> m = new Map<String, List<ID>>();
        for(Class__c c : className){
        	system.debug(c.name);
            for(Student__c s : c.Students__r){
                system.debug(s.id);
            }
        }
    }
}