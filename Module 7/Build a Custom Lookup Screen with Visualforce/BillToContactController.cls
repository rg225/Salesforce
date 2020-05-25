public with sharing class BillToContactController {
    
    private ApexPages.StandardController controller;
    public Opportunity opportunityRecord{get;set;}
    public Id contactId{get;set;}
    
    public BillToContactController(ApexPages.StandardController controller){
        this.controller = controller;
        this.controller.addFields(new List<String>{'Name', 'BillToContact__c', 'Manager__c'});
        this.opportunityRecord = (Opportunity) controller.getRecord();
        this.contactId = this.opportunityRecord.BillToContact__c;
    }
    
    // To get ManagerRelatedContacts in VF page
    public List<SelectOption> getManagerRelatedContacts(){
        List<SelectOption> options = new List<SelectOption>();
        for(Contact contactRecord: [SELECT Id, Name FROM Contact WHERE AccountId=:opportunityRecord.Manager__c]){
            options.add(new SelectOption(contactRecord.Id, contactRecord.Name));
        }
        return options;
    }
    
    public PageReference save(){
        this.opportunityRecord.BillToContact__c = this.contactId;
        return this.controller.save();
    }
    
    public PageReference clear(){
        this.opportunityRecord.BillToContact__c = null;
        return this.controller.save();
    }
}