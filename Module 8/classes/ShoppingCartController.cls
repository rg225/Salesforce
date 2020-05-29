public class ShoppingCartController { 
    public boolean renderProductsTable{get; set;}
    public boolean renderCart{get; set;}
    public boolean renderInvoice{get; set;}
    public boolean isCartEmpty{get; set;}
    public Map<Id,Boolean> isSelected{get;set;}
    public String searchText{get;set;}
    public Id productId{get;set;}
    public String invoiceNumber{get;set;}
    public Decimal finalTotal{get;set;}
    public String finalTotalInCurrency{get;set;}
    ShoppingCartService shoppingCartServiceObj;
    public List<Product2> selectedProductsList{get;set;}
    public String purchaseSort{get;set;}
    public String productSortBy{get;set;}
    public fflib_QueryFactory.SortOrder sortDirection;
    
    // ShoppingCartController Constructor
    public ShoppingCartController(){
        sortDirection = fflib_QueryFactory.SortOrder.DESCENDING;
        isCartEmpty = false;
        renderProductsTable = false;
        renderCart = false;
        renderInvoice = false;
        shoppingCartServiceObj = new ShoppingCartService();
        invoiceNumber = '476289034';
    } 
    
    // StandardSetController For Purchased Orders
    public ApexPages.StandardSetController setConPurchase {
        get {
            if(setConPurchase == null) {
                setConPurchase = new ApexPages.StandardSetController(ShoppingCartService.getPurchaseOrders(purchaseSort,sortDirection));
                setConPurchase.setPageSize(8);
            }
            return setConPurchase;
        }
        set;
    }
    
    // StandardSetController For ProductList
    public ApexPages.StandardSetController setConProduct {
        get {
            if(setConProduct == null) {
                setConProduct = new ApexPages.StandardSetController(ShoppingCartService.getProducts(searchText,productSortBy,sortDirection));
                setConProduct.setPageSize(8);
            }
            return setConProduct;
        }
        set;
    }
    
    // Return List of Purchase orders
    public List<PurchasedOrder__c> getPurchasedOrders(){
        List<PurchasedOrder__c> test = (List<PurchasedOrder__c>) setConPurchase.getRecords();
        return (List<PurchasedOrder__c>) setConPurchase.getRecords();
    }
    
    // Sort the purchased order table 
    public void sortPurchasedOrder(){
        setConPurchase = null;
        sortDirection = (sortDirection == fflib_QueryFactory.SortOrder.ASCENDING) ? fflib_QueryFactory.SortOrder.DESCENDING : fflib_QueryFactory.SortOrder.ASCENDING;
    }
    
    // Sort the purchased order table 
    public void sortProducts(){
        setConProduct = null;
        sortDirection = (sortDirection == fflib_QueryFactory.SortOrder.ASCENDING) ? fflib_QueryFactory.SortOrder.DESCENDING : fflib_QueryFactory.SortOrder.ASCENDING;
    }
    
    // To display Product table
    public void getProductsPanel(){
        renderProductsTable = true;     
    }
    
    // To display cart
    public void addItemTocart(){
        renderCart = true;
    }
    
    // return list of WrapperProducts
    public List<ShoppingCartService.WrapperProducts> getWrapperProducts(){
        getSelectedProducts();
        return shoppingCartServiceObj.getWrapperProductsList((List<Product2>) setConProduct.getRecords());
    }
    
    private void getSelectedProducts(){
        shoppingCartServiceObj.getSelectedProducts();
    }
    
    // When user search in the search box
    public void search(){
        setConProduct = null;
    }
    
    // To add products
    public void addProductsToCart(){
        getSelectedProducts();
        Integer quantity = 1;
        Boolean status = shoppingCartServiceObj.addProductsToCart(quantity);
        if(status == true ){
            renderCart = true;   
        }
        else{
            renderCart = false; 
        }
    }
    
    // When user change the quantity of product update the quantity
    public void updateCartQuantity(){
        shoppingCartServiceObj.updateCartQuantity(productId);
    }
    public List<ShoppingCartService.WrapperCart> getWrapperCartProducts(){
        return shoppingCartServiceObj.getWrapperCartProductsList();
    }
     
    // To remove products from the cart
    public void deleteProductFromCart(){
        shoppingCartServiceObj.deleteProductFromCart(productId);
        if(shoppingCartServiceObj.isCartEmpty()){
            renderCart = false;
        }
    }
    // Show invoice block when user click on checkout and hide other
    public void showInvoice(){
        renderCart = false;
        renderProductsTable = false;
        renderInvoice = true;
    }
    public List<Product2> getProducts(){
        return (List<Product2>) setConProduct.getRecords();
    }
    // supply invoice data
    public List<ShoppingCartService.WrapperCart> getInvoice(){
        Integer tempInvoiceNumber = Integer.valueof(invoiceNumber) + 1; 
        invoiceNumber = String.valueOf(tempInvoiceNumber);
        finalTotal = shoppingCartServiceObj.finalTotalPriceOfCart();
        finalTotalInCurrency = '$'+finalTotal;
        return getWrapperCartProducts();
    }
    
    // hide blocks after placing order
    public void placeOrder(){
        renderCart = false;
        renderInvoice = false;
        renderProductsTable = false;
        setConProduct = null;
        setConPurchase = null;
        shoppingCartServiceObj.placeOrder();
    }
}