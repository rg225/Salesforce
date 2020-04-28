@isTest
public class TestClassCustomStatus {

    /**
     * Class Custom_Status is reset,  so all students will getting deleted
     *  
     * */    
    @isTest
    static void classCustomStatusTestWillReset(){

        // Create data
        Class__c newClass = new Class__c(MaxSize__c = 30, Fee__c= 600, Name = 'ECE', Custom_Status__c = 'New');
        insert newClass;
        Student__c newStudent = new Student__c(Name = 'Gopal', LastName__c = 'Gupta', Class__c = newClass.Id);
        insert newStudent;
        
        // Perform Test
        Test.startTest();
        newClass.Custom_Status__c = 'Reset';
        Database.SaveResult result = Database.update(newClass, false);
        Test.stopTest();
     

        system.assert(result.isSuccess());      
        
        // Check number of students 
        List<Student__c> student = [SELECT Id FROM Student__c];
        system.assertEquals(0,student.size());
    } 
    
    /**
     * Class Custom_Status is open,  so all students will remaining as it is
     *  
     * */  
    @isTest
    static void classCustomStatusTestWillOpen(){
        //Create Data
        Class__c newClass = new Class__c(MaxSize__c = 30, Fee__c= 600, Name = 'ECE', Custom_Status__c = 'New');
        insert newClass;
        Student__c newStudent = new Student__c(Name = 'gopal', LastName__c = 'gupta', Class__c = newClass.Id);
        insert newStudent;
        
        // Perform Test
        Test.startTest();
        newClass.Custom_Status__c = 'Open';
        Database.SaveResult result = Database.update(newClass, false);
        Test.stopTest();
     
        system.assert(result.isSuccess());      
        
        // Check number of students
        List<Student__c> student = [SELECT id FROM Student__c];
        system.assertEquals(1,student.size());
    } 
    
}