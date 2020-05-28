public class PurchaseOrderSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return  PurchasedOrder__c.sObjectType.getDescribe().fields.getMap().values();  
    }
    public Schema.SObjectType getSObjectType() {
        return PurchasedOrder__c.sObjectType;
    }
    // Without Sorting 
    public List<PurchasedOrder__c> getPurchaseOrderList() {   
        return (List<PurchasedOrder__c>) Database.query(newQueryFactory().toSOQL());
    }
    // With Sorting
    public List<PurchasedOrder__c> getSortedPurchaseOrderList(String sortBy, String sortDirection) {  
        if(sortDirection == 'ASC'){
            return (List<PurchasedOrder__c>) Database.query(newQueryFactory().setOrdering(sortBy, fflib_QueryFactory.SortOrder.ASCENDING).toSOQL());
        }
        else{
         	return (List<PurchasedOrder__c>) Database.query(newQueryFactory().setOrdering(sortBy, fflib_QueryFactory.SortOrder.DESCENDING).toSOQL()); 
        }
    }
}