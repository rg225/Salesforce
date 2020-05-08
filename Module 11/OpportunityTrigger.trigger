trigger OpportunityTrigger on Opportunity (before update) {
    
    // When opportunity updated
    if (Trigger.isUpdate){
        UpdateStatusEmail.sendUpdateStatusEmail(Trigger.newMap, Trigger.OldMap);
    }
}