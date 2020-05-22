public class AccountSearchController {
    
    public Integer listOfAccountsSize{get;set;}
    public String billingCity{get;set;}
    public String billingState{get;set;}
    public String billingCountry{get;set;}
    public List<Account> listOfAccounts{get;set;}
    public ApexPages.StandardSetController setController{get; set;}
    
    // For the pagination
    public Integer resultSize{get;set;}
    public Integer pageNumber{get;set;}
    public Integer pageSize {get; set;}
    
    public AccountSearchController(){
        listOfAccountsSize=10;
        billingCity = '';
        billingState = '';
        billingCountry = '';
        resultSize = 0;
        pageSize = 1;
        pageNumber = 0;
        getAccounts();
    }
    
    public void getAccounts(){
        String query =  'SELECT Name , BillingCity, BillingState, BillingCountry FROM Account ';
        
        // For the filtered result
        if(!String.isBlank(billingCity) || !String.isBlank(billingState) || !String.isBlank(billingCountry)){
            query += 'WHERE';
            if ( !String.isBlank(billingCity) ){
                query+= ' BillingCity like '+ '\'%'+billingcity+'%\'' + ' AND ';
            }
            if ( !String.isBlank(billingState) ){
                query+= ' BillingState like '+ '\'%'+billingstate+'%\''+' AND ';
            }            
            if ( !String.isBlank(billingCountry) ){
                query+= ' BillingCountry like '+ '\'%'+billingcountry+'%\'' +' AND ';
            }
            query = query.removeEnd('AND ');
        }
        
        setController = new ApexPages.StandardSetController(Database.query(query));
        setController.setPageSize(listOfAccountsSize);
        listOfAccounts = setController.getRecords();
        
        // For the pagination
        pageNumber = setController.getPageNumber();
        pageSize = listOfAccountsSize;
        resultSize = setController.getResultSize(); 
    }
    
    public void firstPage(){
        setController.first();
        listOfAccounts = setController.getRecords();
        pageNumber = setController.getPageNumber();
    }
    
    public void lastPage(){
        setController.last();
        listOfAccounts = setController.getRecords();
        pageNumber = setController.getPageNumber();
    }
    
    public void nextPage(){
        setController.next();
        listOfAccounts = setController.getRecords();
        pageNumber = setController.getPageNumber();
    }
    
    public void previousPage(){
        setController.previous();
        listOfAccounts = setController.getRecords();
        pageNumber = setController.getPageNumber();
    }
}