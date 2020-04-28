@isTest
public class TestStudentLimitsInClass {

    /**
     * Add Students more then the class max size
     */
    @isTest
    static void studentLimitsInClassTestWithMoreThanLimit(){
        
        // Creating some data using the class factory
        TestDataFactory data = new TestDataFactory();
        List<Class__c> newClasses = data.newClasses;
        
        // there is already 5 student in class and here we are adding 36 more students
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 36; i++){

            // class0 is selected by defalut here
            Class__c cls = newClasses[0];
            Student__c newStudent = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id, Sex__c = 'Male');
        	students.add(newStudent);
        }
        
        // Perform test
        Test.startTest();
        Database.SaveResult[] result = Database.insert(students, false);
        Test.stopTest();
        
        // fetech the data and compare
        Class__c clss= [SELECT Id,MyCount__c FROM Class__c WHERE Name = 'Class0'];
        system.assertEquals(5, clss.MyCount__c);
    }
    
    /**
     * Add Students less then the class max size
     */
    @isTest
    static void studentLimitsInClassTestWithLessThanLimit(){
        
        // Creating some data using the class factory
        TestDataFactory data = new TestDataFactory();
        List<Class__c> newClasses = data.newClasses;
        
        // there is already 5 student in class and here we are adding 20 more students
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0; i < 20; i++){

            // class0 is selected by defalut here
            Class__c cls = newClasses[0];
            Student__c newStudent = new Student__c(Name = 'Name'+i, LastName__c = 'Last', Class__c = cls.Id, Sex__c = 'Male');
        	students.add(newStudent);
        }
        
        // Perform test
        Test.startTest();
        Database.SaveResult[] result = Database.insert(students, false);
        Test.stopTest();
        
        // fetech the data and compare
        Class__c cls= [SELECT Id,MyCount__c FROM Class__c WHERE Name = 'Class0'];
        system.assertEquals(25, cls.MyCount__c);
    }
}