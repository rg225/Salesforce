@isTest
public class TestClassDeletion {

    /***
     * This test case is with 3 females. 2 are in same class and one in the other class.
     * so more then 1 females class will not be deleted, after deletion we will see 1 class
     */
    @isTest
    static void classDeletionWith3Female(){
        
        // Use the Test data factory to create some data
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        
        // By default sex is male so change it for 3 students
        students[0].Sex__c = 'Female';
        students[1].Sex__c = 'Female';
        students[21].Sex__c = 'Female';
        update students;
        
        // Perform test
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(classes, false);
        Test.stopTest();
        
        // To check the number of current classes
        List<Class__c> cls = [SELECT Id FROM Class__c];
        System.assertEquals(1, cls.size());
    }
    
    /***
     * This test case is with 80 females. Every class having 4 female students.
     * So no class getting deleted.
     */
    @isTest
    static void classDeletionWith80Female(){
        
        // Use the Test data factory to create some data
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        
        // By default sex is male so change 80 students
        for(Integer index = 0; index < 80; index++){
            students[index].Sex__c = 'Female';
        }
        // Now we set 4 female in every class and than update
        update students;
        
        // Perform test
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(classes, false);
        Test.stopTest();
        
        // To check the number of current classes
        List<Class__c> cls = [SELECT Id FROM Class__c];
        
        //System.debug(cls.size());
        System.assertEquals(20, cls.size());
    }
    
    /***
     * This test case is with 0 females.
     * So all classes will be deleted.
     */
    @isTest
    static void classDeletionWithNoFemale(){
        
        // Use the Test data factory to create some data
        TestDataFactory data = new TestDataFactory();
        List<Class__c> classes = data.newClasses;
    	List<Student__c> students = data.newStudents;
        
        // Perform test
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(classes, false);
        Test.stopTest();
        
        // To check the number of current classes
        List<Class__c> cls = [SELECT Id FROM Class__c];
        
        //System.debug(cls.size());
        System.assertEquals(0, cls.size());
        
        for(Database.DeleteResult result : results){
            System.assertNotEquals('Cannot delete Class because in this class more than 1 girls exist.',
                             result.getErrors()[0].getMessage());
        }
        
    }
}