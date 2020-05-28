Public class WrapperProductWrapper{
    Public Product2 con{get;set;}
    Public boolean bool{get;set;}
   	public Integer quantity{get; set;}
   	public Decimal availableQuantity{get;set;}
   	public Decimal totalPrice{get; set;}
    
    public WrapperProductWrapper(Product2 c,boolean bool)
    {
        this.con = c;
        this.bool = bool;
        this.quantity = 1;
        this.availableQuantity = c.Quantity_Available__c;
    }
}