@isTest
public class ShoppingCartControllerTest {
    @testSetup
    static void createProducts(){
        List<Product2> products = new List<Product2>();
        for(Integer i = 0; i < 5; i++){
            Product2 product = new Product2(Name = 'Product'+i, ProductCode = 'Code'+i, Price_Per_Unit__c = 20, Quantity_Available__c = 10);
            products.add(product);
        }
        insert products;
        
        List<PurchasedOrder__c> PurchasedOrders = new List<PurchasedOrder__c>();
        for(Integer i = 0; i < 5; i++){
            PurchasedOrder__c PurchasedOrder = new PurchasedOrder__c(Order_Price__c = 2*(i+1), Status__c = 'Pending');
            PurchasedOrders.add(PurchasedOrder);
        }
        insert PurchasedOrders;
    }
    @isTest
    static void testGetPurchasedOrders(){
        ShoppingCartController scc = new ShoppingCartController();
        List<PurchasedOrder__c> PurchaseList = scc.getPurchasedOrders();
        System.assertEquals(5, PurchaseList.size());        
    }
    @isTest
    static void testSortPurchasedOrderForOneTimeCalling(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.sortPurchasedOrder();
        System.assertEquals('ASC', scc.sortDirection);        
    }
    @isTest
    static void testSortPurchasedOrderForTwoTimeCalling(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.sortPurchasedOrder();
        scc.sortPurchasedOrder();
        System.assertEquals('DESC', scc.sortDirection);        
    }
    @isTest
    static void testSortProductForOneTimeCalling(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.sortProducts();
        System.assertEquals('ASC', scc.sortDirection);        
    }
    @isTest
    static void testSortProductsForTowTimeCalling(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.sortProducts();
        scc.sortProducts();
        System.assertEquals('DESC', scc.sortDirection);        
    }
    @isTest
    static void testAddItemTocart(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.addItemTocart();
        System.assert(scc.renderCart);        
    }
    
    @isTest
    static void testGetWrapperCartProductsWhenTwoProductsSelected(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        wp[1].selected = true;
        scc.addProductsToCart();
        List<WrapperCart> wc =  scc.getWrapperCartProducts();
        System.assertEquals(2, wc.size());    
        System.assert(scc.renderCart);             
    }
    @isTest
    static void testGetWrapperCartProductsWhenNoProductsSelected(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        scc.addProductsToCart();
        List<WrapperCart> wc =  scc.getWrapperCartProducts();
        System.assertEquals(0, wc.size());     
        System.assert(!scc.renderCart);       
    }
    @isTest
    static void testProductQuantityWhenProductIsAddedToCartAndQunatityUnchanged(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        scc.addProductsToCart();
        System.assertEquals(9, wp[0].quantity);     
    }
    
    @isTest
    static void testProductQuantityWhenProductIsAddedToCartAndQunatityChanged(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        wp[1].selected = true;
        scc.addProductsToCart();
        List<WrapperCart> wc =  scc.getWrapperCartProducts();
        wc[0].productInCartQuantity = 4;
        scc.productId = wc[0].product.id;
        scc.updateCartQuantity();
        System.assertEquals(6, wp[0].quantity);   
    }
    @isTest
    static void testProductQuantityWhenProductIsAddedToCartAndDeleted(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        wp[1].selected = true;
        scc.addProductsToCart();
        List<WrapperCart> wc =  scc.getWrapperCartProducts();
        wc[0].productInCartQuantity = 4;
        scc.productId = wc[0].product.id;
        scc.deleteProductFromCart();
        wc =  scc.getWrapperCartProducts();
        System.assertEquals(1, wc.size()); 
        System.assertEquals(10, wp[0].quantity);
    }
    @isTest
    static void testShowInvoice(){
        ShoppingCartController scc = new ShoppingCartController();
        scc.showInvoice();
        System.assert(!scc.renderCart);  
        System.assert(!scc.renderProductsTable);  
        System.assert(scc.renderInvoice);        
    }
    @isTest
    static void testGetInvoice(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        wp[1].selected = true;
        scc.addProductsToCart();
        List<WrapperCart>  wc = scc.getInvoice();
        System.assertEquals(2, wc.size()); 
        System.assertEquals(40, scc.finalTotal);
    }
    @isTest
    static void testInsertedResultPurchasedOrderLineItem(){
        ShoppingCartController scc = new ShoppingCartController();
        List<WrapperProducts> wp = scc.getWrapperProducts();
        wp[0].selected = true;
        wp[1].selected = true;
        scc.addProductsToCart();
        List<WrapperCart>  wc = scc.getInvoice();
        scc.placeOrder();
        List<Purchase__c> p = [SELECT Id FROM Purchase__c];
        System.assertEquals(2, p.size()); 
    }
}