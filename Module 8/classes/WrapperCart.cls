public class WrapperCart {
    public Product2 product {get; set;}
    public Integer productInCartQuantity {get; set;}
    public Decimal totalProductPrice{get; set;}
    public String totalProductPriceInCurrency{get; set;} 
    public WrapperCart(Product2 prod, Integer quantity) {
        product = prod;
        productInCartQuantity = quantity;
        totalProductPrice = product.Price_Per_Unit__c;
        totalProductPriceInCurrency = '$'+totalProductPrice;
    }
}