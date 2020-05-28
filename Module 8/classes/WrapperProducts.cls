public class WrapperProducts {
    public Product2 product {get; set;}
    public Boolean selected {get; set;}
    public Integer quantity {get; set;}
    public WrapperProducts(Product2 prod, Boolean bool) {
        product = prod;
        quantity = (Integer)prod.Quantity_Available__c;
        selected = bool;
    }
}