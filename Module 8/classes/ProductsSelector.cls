public class ProductsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return  Product2.sObjectType.getDescribe().fields.getMap().values();  
    }
    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }
    // without search value
    public List<Product2> getProductsList() { 
        fflib_QueryFactory qf = newQueryFactory();
        qf.setCondition('Quantity_Available__c > 0 ');
		return (List<Product2>) Database.query(qf.toSOQL());
    }
    
    // with search value and sorting as well
    public List<Product2> searchProducts(String searchText, String sortBy, fflib_QueryFactory.SortOrder sortDirection) {
        searchText = '%'+searchText+'%' ;
        fflib_QueryFactory qf = newQueryFactory();
        qf.setCondition('Quantity_Available__c > 0 ');
        qf.setOrdering(sortBy, sortDirection);
        return (List<Product2>) Database.query(qf.toSOQL());
    }
}