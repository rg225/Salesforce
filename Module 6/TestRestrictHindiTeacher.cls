@isTest
public class TestRestrictHindiTeacher {

    /**
     * Here 2 hindi teacher and 18 other non hindi teacher will inserted 
     * So only 18 teacher will getting inserted
     */
    @isTest
    static void restrictHindiTeacherWhenInsert(){
        
        // Creating data using data factory
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        
        // Creating data for teach with default subject maths
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++){
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'Maths');
            newTeaches.add(newTeach);
        }

        // change the subject of 2 teaches
        newTeaches[0].Subject__c = 'Hindi;English';
        newTeaches[15].Subject__c = 'Hindi;Science';
        
        // Perform test
        Test.startTest();
        Database.SaveResult[] result = Database.insert(newTeaches, false);
        Test.stopTest();
        
        // fetch data from teach to check how many records are getting inserted
        List<Teach__c> teach= [SELECT Id FROM Teach__c];
        system.assertEquals(18, teach.size());
    }
    
    /**
     * Here all teacher teaches hindi so no teacher will getting  inserted inside the database
     */
    @isTest
    static void restrictHindiTeacherTestWhenAllTeachsHindi(){
        // Creating data using data factory
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        
         // Creating data for teach with default subject hindi and english
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++){
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'Hindi;English');
            newTeaches.add(newTeach);
        }
        // Perform test
        Test.startTest();
        Database.SaveResult[] results = Database.insert(newTeaches, false);
        Test.stopTest();
        
        // Fetch the teach records
        List<Teach__c> teach = [SELECT Id FROM Teach__c];
        system.assertEquals(0, teach.size());
        
        for(Database.SaveResult result : results){
            System.assertEquals('Sorry Hindi teachers can not create the account',
                             result.getErrors()[0].getMessage());
        }
    }
    
    /**
     * Here all teacher by default teaches English 
     * Update english with hindi but no record can update with hindi
     */
    @isTest
    static void restrictHindiTeacherTestForUpdate(){
        
        // Create data using data factory
        TestDataFactory data = new TestDataFactory();
        List<Contact> newTeachers = data.newTeachers;
        List<Class__c> newClasses = data.newClasses;
        
        // create teach data with by default english subject
        List<Teach__c> newTeaches = new List<Teach__c>();
        for(Integer i = 0; i < 20; i++){
            Teach__c newTeach = new Teach__c(Teacher__c = newTeachers[i].Id, Class__c = newClasses[i].Id, Subject__c = 'English');
            newTeaches.add(newTeach);
        }
        insert newTeaches;
        
        // Perform test
        Test.startTest();

        // Update hindi with english
        newTeaches[0].Subject__c = 'Hindi';
        newTeaches[15].Subject__c = 'Hindi';
        Database.SaveResult[] results = Database.update(newTeaches, false);
        Test.stopTest();
        
        // fetch data and compare using assertEquals
        List<Teach__c> teach= [SELECT Id FROM Teach__c];
        
        system.assertEquals(0, teach.size());
        for(Database.SaveResult result : results){
            System.assertEquals('Sorry Hindi teachers can not create the account',
                             result.getErrors()[0].getMessage());
        }
    }
}