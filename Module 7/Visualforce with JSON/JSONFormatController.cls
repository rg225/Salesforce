public class JSONFormatController {
    public String jsonData ;
    public String getJsonData(){
        List<Student__c> studentRecords = [ SELECT Id, Name, LastName__c, DOB__c, Sex__c FROM Student__c LIMIT 5];
        return Json.serialize( studentRecords );
    }
}