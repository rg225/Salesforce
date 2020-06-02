global with sharing class DeleteStudentRemotingController {
    @RemoteAction
    global static string deleteStudents(String records){
        List<Student__c> studentsToBeDeleted = new List<Student__c>();
        List<Id> recordsIds = records.split(',');
        for(Id studentId : recordsIds){
            Student__c student = new Student__c();
            student.Id = studentId;
            studentsToBeDeleted.add(student);
        }
        delete studentsToBeDeleted;
        return 'success' ;
    }
}