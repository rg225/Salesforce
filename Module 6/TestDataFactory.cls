@isTest
public class TestDataFactory {

    // Public variables which we can use outside of the class
    public List<Class__c> newClasses = new List<Class__c>();
    public List<Student__c> newStudents = new List<Student__c>();
    public List<Contact> newTeachers = new List<Contact>();
    public List<Teach__c> newTeaches = new List<Teach__c>();
    
    // Constructor
    public TestDataFactory() {

        // Generate the 20 classes data
        for(Integer i = 0; i < 20; i++){
            Class__c newClass = new Class__c(MaxSize__c = 30, Fee__c= 600, Name = 'Class'+i, Custom_Status__c = 'New');
        	newClasses.add(newClass);
        }
        insert newClasses;
        
        // Generate the 100 students data
        for(Integer i = 0; i < 100; i++){
            // every class will get only 5 students using i%20 this will give number 0 to 19
            Class__c cls = newClasses[Math.Mod(i,20)];
            Student__c newStudent = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id, Sex__c = 'Male');
        	newStudents.add(newStudent);
        }
        insert newStudents;
        
        
        // Generate the 20 Teachers data
        for(Integer i = 0; i < 20; i++){
            Contact newTeacher = new Contact(FirstName = 'Teacher'+i, LastName = 'Last');
        	newTeachers.add(newTeacher);
        }
        insert newTeachers;
        
        
        
    }
}