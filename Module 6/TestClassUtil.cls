@isTest
public class TestClassUtil {

    // Test getAllStudents function
    @isTest
    static void testAllClassStudent(){
        
        // Create test data
        Class__c cls = new Class__c(Name = 'ECE');
        insert cls;
        List<Student__c> Students = new List<Student__c>();
        for(Integer i = 0; i < 10; i++){
            Student__c student = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id);
            Students.add(student);
        }
        insert Students;
        
        // Test getAllStudents function 
        List<Student__c> studentList = ClassUtil.getAllStudents(cls.Id);
        
        // Comapre results
        for(Integer i = 0; i < 10; i++){
            system.assertEquals(Students[i].Id, studentList[i].Id);
        }
    }
    
    // Test getAllStudents function
    @isTest
    static void testGetMapOfStudents(){
        
        // Create test data
        Class__c cls = new Class__c(Name = 'ECE');
        insert cls;
        List<Student__c> Students = new List<Student__c>();
        for(Integer i = 0; i < 10; i++){
            Student__c student = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id);
            Students.add(student);
        }
        insert Students;
        
        // Test getAllStudents function 
        map<String, Set<Id>> classNameWithStudents = ClassUtil.getMapOfStudents();
        
        // Match excpected result with actual
        for (String classNameWithStudent : classNameWithStudents.keySet()){
            // to traverse the actual 'students' list
            Integer i = 0;
			for(Id stuId : classNameWithStudents.get(classNameWithStudent )){
                system.assertEquals(Students[i].Id, stuId);
                i++;
            }
            system.assertEquals(cls.Name, classNameWithStudent);
        }
    }
}