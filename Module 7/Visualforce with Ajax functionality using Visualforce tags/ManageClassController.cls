public class ManageClassController {
    public Id classId{get;set;}
   
    public ApexPages.StandardSetController setController{
        get{
            if(setController==null){
                setController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name, Board__c, Fee__c, Max_Size__c, Class_Teacher__c FROM Class__c]));
            }
            return setController;
        }
        set;
    }
   
    public List<Class__c> getListOfClasses(){
        return setController.getRecords();
    }
   
    // To delete class
    public void deleteClass(){
        delete new Map<Id,Class__c>(getListOfClasses()).get(classId);
        classId=null;
        setController = null;
    }
   
    public Class__c getClass(){
        return new Map<Id,Class__c>(getListOfClasses()).get(classId);
    }
   
    public void save(){
        update new Map<Id,Class__c>(getListOfClasses()).get(classId);
        classId=null;
        setController = null;
    }
   
    public void cancel(){
        classId=null;
    }
}