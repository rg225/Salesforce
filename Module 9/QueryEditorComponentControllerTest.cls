@isTest
public class QueryEditorComponentControllerTest {
    @testSetup
    static void createContacts(){
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++){
            Contact contact = new Contact(LastName = 'contact'+i);
            contacts.add(contact);
        }
        insert contacts;
    }
    @isTest
    static void testGetRecordsList(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        qec.queryToBeExecuted = 'SELECT Id, Name FROM Contact';
        List<sObject> con = qec.getRecordsList();
        System.assertEquals(5, con.size());        
    }
    @isTest
    static void testCreateQuery(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        String query = 'SELECT Id, Name FROM Contact';
        String q = qec.createQuery(query);
        System.assertEquals('SELECT Id, Name FROM Contact', q);        
    }
    @isTest
    static void testCreateQueryWhenSortingLinkClicked(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        qec.sortByMethod(); 
        qec.setSortBy('Name'); 
        String query = 'SELECT Id, Name FROM Contact';
        String q = qec.createQuery(query);
        System.assertEquals('SELECT Id, Name FROM Contact ORDER BY Name DESC', q);        
    }
    @isTest
    static void testExecuteQueryWithValidQuery(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        String query = 'SELECT Id, Name FROM Contact';
        List<sObject> con = qec.executeQuery(query);
        System.assertEquals(5, con.size());        
    }
    
    @isTest
    static void testExecuteQueryWithInvalidQuery(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        String query = 'SELECT Idd, Name FROM Contact';
        List<sObject> con = qec.executeQuery(query);
        System.assertEquals(null, con);        
    }
    @isTest
    static void testGetDisplayFieldsWithValidQuery(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        String query = 'SELECT Id, Name FROM Contact';
        List<sObject> con = qec.getDisplayFields(query);
        System.assertEquals(5, con.size());        
    }
    
    @isTest
    static void testGetDisplayFieldsWithInvalidQuery(){
        QueryEditorComponentController qec = new QueryEditorComponentController();
        String query = 'SELECT Idd, Name FROM Contact';
        List<sObject> con = qec.getDisplayFields(query);
        System.assertEquals(null, con);        
    }
    
}