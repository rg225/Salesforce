public class ShoppingCartService {
    public Map<Id,boolean> isSelectedMap{get;set;}
    Map<Id,WrapperProducts> WrapperProductsMap;
    Map<Id,WrapperProducts> WrapperProductsMapClone;
    Map<Id,WrapperCart> WrapperCartProductsMap;
    Map<Id,Integer> productsQuantityMap{get;set;}
    public Map<Id,Integer> cartProductsQuantityMap{get;set;}
    public ShoppingCartService(){
        WrapperProductsMapClone = new Map<Id,WrapperProducts>();
        WrapperCartProductsMap = new Map<Id,WrapperCart>();
        isSelectedMap = new Map<Id,boolean>();
        productsQuantityMap = new Map<Id,Integer>();
        cartProductsQuantityMap = new Map<Id,Integer>();
    }
    
    // to get the list of purchased orders
    public static List<PurchasedOrder__c> getPurchaseOrders(String sortBy, String sortDirection){
        if(!String.IsBlank(sortBy)){
            return new PurchaseOrderSelector().getSortedPurchaseOrderList(sortBy,sortDirection);
        }
        else{
            return new PurchaseOrderSelector().getPurchaseOrderList();
        }
    }
    // to get the list of products
    public static List<Product2> getProducts(String searchText, String purchaseSort, String sortDirection){
        if(!(String.IsBlank(searchText) && String.IsBlank(purchaseSort))){
            return new ProductsSelector().searchProducts(searchText,purchaseSort,sortDirection);
        }
        else{
            return new ProductsSelector().getProductsList();
        }
    }
    
    // to get the list of WrapperProducts
    public List<WrapperProducts> getWrapperProductsList(List<Product2> standardControllerProductRecords){
        WrapperProductsMap = new Map<Id,WrapperProducts>();
        for(Product2 prod : standardControllerProductRecords){
            if(isSelectedMap.ContainsKey(prod.id)){
                WrapperProductsMap.put(prod.id, new WrapperProducts(prod,true));
            }
            else{
                WrapperProductsMap.put(prod.id, new WrapperProducts(prod,false));
            }
            if(productsQuantityMap.containsKey(prod.id)){
                WrapperProductsMap.get(prod.id).quantity = productsQuantityMap.get(prod.id);
            }
        }
        return WrapperProductsMap.values();
    }
    
    // to update the selected products in maps
    public void getSelectedProducts(){
        if(WrapperProductsMap != null){
            for(WrapperProducts wrapperProduct : WrapperProductsMap.values()){
                if(wrapperProduct.selected == true){
                    isSelectedMap.put(wrapperProduct.product.id, wrapperProduct.selected);
                    WrapperProductsMapClone.put(wrapperProduct.product.id, wrapperProduct);
                }
                else{
                    isSelectedMap.remove(wrapperProduct.product.id);
                    WrapperProductsMapClone.remove(wrapperProduct.product.id);
                }
            }
        } 
    }
    
    // to add the qunatity of maps
    public boolean addProductsToCart(Integer quantity){
        system.debug(isSelectedMap);
        if(isSelectedMap.values().size() != 0){
            for(WrapperProducts wrapperProduct : WrapperProductsMapClone.values()){
                if(isSelectedMap.containsKey(wrapperProduct.product.id) && wrapperProduct.quantity > 0 && quantity <= wrapperProduct.quantity){
                    if(! WrapperCartProductsMap.containsKey(wrapperProduct.product.id)){
                        WrapperProductsMapClone.get(wrapperProduct.product.id).quantity -= quantity;
                        WrapperCartProductsMap.put(wrapperProduct.product.id, new WrapperCart(wrapperProduct.product, quantity));
                        productsQuantityMap.put(wrapperProduct.product.id, WrapperProductsMapClone.get(wrapperProduct.product.id).quantity);
                        cartProductsQuantityMap.put(wrapperProduct.product.id, quantity);
                    }
                    else{
                        WrapperProductsMapClone.get(wrapperProduct.product.id).quantity -= quantity;
                        WrapperCart cartObj = WrapperCartProductsMap.get(wrapperProduct.product.id);
                        cartObj.productInCartQuantity += quantity;
                        cartObj.totalProductPrice = wrapperProduct.product.Price_Per_Unit__c * cartObj.productInCartQuantity;
                        cartObj.totalProductPriceInCurrency = '$'+cartObj.totalProductPrice;
                        cartProductsQuantityMap.put(wrapperProduct.product.id, cartObj.productInCartQuantity);
                        WrapperCartProductsMap.put(wrapperProduct.product.id, cartObj);
                        productsQuantityMap.put(wrapperProduct.product.id, WrapperProductsMapClone.get(wrapperProduct.product.id).quantity);
                    }
                } 
            }
            return true;
        }
        return false;
    }
    // to get the list of WrapperCart
    public List<WrapperCart> getWrapperCartProductsList(){
        return WrapperCartProductsMap.values();
    }
    // to update the products table quantity and check the quantity is possible or not
    public void updateCartQuantity(Id cartProductId){
        Integer newQuantity = WrapperCartProductsMap.get(cartProductId).productInCartQuantity;
        Integer oldQuantity = cartProductsQuantityMap.get(cartProductId);
        Integer updatedQuantity = newQuantity - oldQuantity;
        if(WrapperProductsMapClone.get(cartProductId).quantity >= updatedQuantity && 
           WrapperCartProductsMap.get(cartProductId).productInCartQuantity > 0){
               WrapperProductsMapClone.get(cartProductId).quantity -=   updatedQuantity;
               productsQuantityMap.put(cartProductId, WrapperProductsMapClone.get(cartProductId).quantity);
               cartProductsQuantityMap.put(cartProductId, newQuantity);
               WrapperCart cartObj = WrapperCartProductsMap.get(cartProductId);
               cartObj.productInCartQuantity = newQuantity;
               cartObj.totalProductPrice = WrapperProductsMapClone.get(cartProductId).product.Price_Per_Unit__c * newQuantity;
               cartObj.totalProductPriceInCurrency = '$'+cartObj.totalProductPrice;
           }
        else if(WrapperCartProductsMap.get(cartProductId).productInCartQuantity <= 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Enter Valid Quantity'));
            WrapperCartProductsMap.get(cartProductId).productInCartQuantity = oldQuantity;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Quantity is greater than Available quantity'));
            WrapperCartProductsMap.get(cartProductId).productInCartQuantity = oldQuantity;
        }
    }
    // to delete the product from WrapperCartProductsMap and update the product table quantity
    public void deleteProductFromCart(Id cartProductId){
        if(WrapperProductsMapClone != null){
            WrapperProductsMapClone.get(cartProductId).quantity += cartProductsQuantityMap.get(cartProductId);
            productsQuantityMap.put(cartProductId, WrapperProductsMapClone.get(cartProductId).quantity);
            WrapperCartProductsMap.remove(cartProductId);
            cartProductsQuantityMap.remove(cartProductId);
        }
    }
    // to calculate the total price
    public Decimal finalTotalPriceOfCart(){
        Decimal finalPrice = 0;
        for(WrapperCart prod: WrapperCartProductsMap.values()){
            finalPrice += prod.totalProductPrice;
        }
        return finalPrice;
    }
    
    // to save the order in org
    public void placeOrder(){
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[]{PurchasedOrder__c.SObjectType, 
            Purchase__c.SObjectType, Product2.SObjectType});
        PurchasedOrder__c purchaseOrder = new PurchasedOrder__c(Order_Price__c = finalTotalPriceOfCart(), Status__c = 'Pending');
        uow.registerNew(purchaseOrder);
        for(WrapperCart prod: WrapperCartProductsMap.values()){
            Product2 product = WrapperProductsMapClone.get(prod.product.id).product;
            product.Quantity_Available__c = WrapperProductsMapClone.get(prod.product.id).quantity;
            uow.registerDirty(product);
            Purchase__c purchaseOrderLineItem = new Purchase__c();
            purchaseOrderLineItem.PurchasedProductId__c = prod.product.Id;
            uow.registerNew(purchaseOrderLineItem, Purchase__c.PurchasedOrderId__c, purchaseOrder);
        }
        isSelectedMap.clear();
        WrapperProductsMap.clear();
        WrapperProductsMapClone.clear();
        WrapperCartProductsMap.clear();
        productsQuantityMap.clear();
        cartProductsQuantityMap.clear();
        uow.commitWork();
    }
}