@isTest
public class TestClassCustomStatus {
    
    /**
     * If custom status is change new to reset then all student related to that class will deleted
     */
    @isTest
    static void classCustomStatusPositiveTest(){

        // Creating data
        Class__c newClass = new Class__c(MaxSize__c = 30, Fee__c= 600, Name = 'ECE', Custom_Status__c = 'New');
        insert newClass;
        Student__c newStudent = new Student__c(Name = 'gopal', LastName__c = 'gupta', Class__c = newClass.Id);
        insert newStudent;
        
        // Test
        Test.startTest();
        newClass.Custom_Status__c = 'Reset';
        Database.SaveResult result = Database.update(newClass, false);
        Test.stopTest();
     
        System.assert(result.isSuccess());      
        
        // fetch number of student in class
        List<Student__c> student = [SELECT id FROM Student__c];
        System.assertEquals(0,student.size());
    } 
    
    /** 
     * If class status is not updated with reset then no student will deleted
     */
    @isTest
    static void classCustomStatusNegativeTest(){
        // create data
        Class__c newClass = new Class__c(MaxSize__c = 30, Fee__c= 600, Name = 'ECE', Custom_Status__c = 'New');
        insert newClass;
        Student__c newStudent = new Student__c(Name = 'gopal', LastName__c = 'gupta', Class__c = newClass.Id);
        insert newStudent;
        
        // test
        Test.startTest();
        newClass.Custom_Status__c = 'Open';
        Database.SaveResult result = Database.update(newClass, false);
        Test.stopTest();
     
        System.assert(result.isSuccess());      
        
        // fetch number of student in class
        List<Student__c> student = [SELECT id FROM Student__c];
        System.assertEquals(1,student.size());
    } 
    
}