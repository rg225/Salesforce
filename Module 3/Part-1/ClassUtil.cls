public class ClassUtil {
    /**
     *  A static function which takes classId as argument and returns all names of the
     *  students in that class as a list.
     */
    public static List<Student__c> getAllStudents(id classId){
        // Selecting the list of students using the class id 
        List<Student__c> listOfStudents = [SELECT Name FROM Student__c WHERE class__r.id =: classId];
        return listOfStudents;
    }
    /**
     * A static function which returns a map where key is class and value is set of studentId in it.
     * @return mapOfStudents 
     */
    public static map<String, Set<Id>> getMapOfStudents(){
        List<Class__c> classNameWithStudents = [SELECT Name, (SELECT Id FROM Students__r) FROM Class__c];
        Map<String, Set<Id>> mapOfStudents = new Map<String, Set<Id>>();

        //  Loop to put key and values in the map
        for(Class__c classNameWithStudent : classNameWithStudents){
            Set<Id> idSet = new Set<Id>();
            // To store the students id in the set
            for(Student__c s : classNameWithStudent.Students__r){
                idSet.add(s.id);
            }
            mapOfStudents.put(classNameWithStudent.Name,idSet);            
        }
        return mapOfStudents;
    }
}