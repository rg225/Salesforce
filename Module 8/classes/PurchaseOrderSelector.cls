public class PurchaseOrderSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return  PurchasedOrder__c.sObjectType.getDescribe().fields.getMap().values();  
    }
    public Schema.SObjectType getSObjectType() {
        return PurchasedOrder__c.sObjectType;
    }
    // Without Sorting  
    public List<PurchasedOrder__c> getPurchaseOrderList() { 
        fflib_QueryFactory qf = newQueryFactory();
		return (List<PurchasedOrder__c>) Database.query(qf.toSOQL());
    }
    // With Sorting
    public List<PurchasedOrder__c> getSortedPurchaseOrderList(String sortBy, fflib_QueryFactory.SortOrder sortDirection) { 
        fflib_QueryFactory qf = newQueryFactory();
        qf.setOrdering(sortBy, sortDirection);
        return (List<PurchasedOrder__c>) Database.query(qf.toSOQL());
    }
}