trigger OpportunityTrigger on Opportunity (before update) {
    
    // When opportunity updated
    if (Trigger.isUpdate){
        OpportunityManager.handleStatusUpdate(Trigger.newMap, Trigger.OldMap);
    }
}