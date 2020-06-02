public class InsertStudentController {
    public String firstName{get;set;} 
    public void insertStudent(){
        if(!String.isEmpty(firstName)){
            createStudentRecord(firstName);
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Name Can not be empty'));
        }
    }
    private void createStudentRecord(String firstName){
        Student__c stu = new Student__c(Name = firstName, lastName__c = 'Gupta', Class__c = 'a012x000006Xkr4' );
        insert stu;
    }
}