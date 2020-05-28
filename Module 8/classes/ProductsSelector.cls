public class ProductsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return  Product2.sObjectType.getDescribe().fields.getMap().values();  
    }
    public Schema.SObjectType getSObjectType() {
        return Product2.sObjectType;
    }
    // without search value
    public List<Product2> getProductsList() {   
        return (List<Product2>) Database.query(newQueryFactory().setCondition('Quantity_Available__c > 0 ').toSOQL());
    }
    
    // with search value and sorting as well
    public List<Product2> searchProducts(String searchText, String sortBy, String sortDirection) {
        searchText = '%'+searchText+'%' ;
        if(sortDirection == 'ASC'){
            return (List<Product2>)  Database.query(newQueryFactory().setCondition('Name Like :searchText AND Quantity_Available__c > 0 ').setOrdering(sortBy, fflib_QueryFactory.SortOrder.ASCENDING).toSOQL());
        }
        else{
         	return (List<Product2>)  Database.query(newQueryFactory().setCondition('Name Like :searchText AND Quantity_Available__c > 0 ').setOrdering(sortBy, fflib_QueryFactory.SortOrder.DESCENDING).toSOQL()); 
        }
    }
}