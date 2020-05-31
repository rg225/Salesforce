public class QueryEditorComponentController {
    public String queryToBeExecuted;
    public List<String> fieldsApiNameList{get;set;}
    public String sortBy;
    public Integer desiredPage{get;set;}
    public Boolean isSortingLinkClicked = false;
    public String sortDir {get;set;}
    public QueryEditorComponentController(){
        queryToBeExecuted = '';
        sortBy = '';
        sortDir = 'ASC';
    }
    public ApexPages.StandardSetController setCon{
        get{
            if(setCon == null){
                List<sObject> displayFields = getDisplayFields(queryToBeExecuted);
                if(displayFields != null){
                    setCon = new ApexPages.StandardSetController(displayFields);
                    setCon.setPageSize(10);
                }
            }
            return setCon;
        }
        set;
    }
    public String getQueryToBeExecuted(){
        return queryToBeExecuted;
    }
    public void setQueryToBeExecuted(String query){
        if(!queryToBeExecuted.equalsIgnoreCase(query)){
            queryToBeExecuted = query;
            isSortingLinkClicked = false;
            setCon = null;
        }
    }
    public void sortByMethod(){
        setCon = null;
        isSortingLinkClicked = true;
    }
    public void setSortBy(String fieldName){
        sortBy = fieldName;
    }
    public String getSortBy(){
        return sortBy;
    }
    public List<sObject> getRecordsList(){
        if(setCon != null){
            desiredPage = setCon.getPageNumber();
            return setCon.getRecords();
        }
        else{
            return null;
        }
    }
    private String createQuery(String query){
        String orderedQuery = query;       
        if(isSortingLinkClicked && String.isNotBlank(getSortBy())){
            if(query.containsIgnoreCase('ORDER BY')){
                orderedQuery = orderedQuery.substring(0, query.indexOfIgnoreCase('ORDER BY') - 1);
            }
            sortDir = sortDir.equals('ASC') ? 'DESC' : 'ASC';
            orderedQuery = orderedQuery + ' ORDER BY ' + getSortBy() + ' ' + sortDir;
            queryToBeExecuted = orderedQuery;
        }
        return orderedQuery;
    }
    private List<sObject> executeQuery(String query){
        String orderedQuery = createQuery(query);
        List<sObject> sObjectList = new List<sObject>();
        try{
            sObjectList = Database.query(orderedQuery);
            
        }
        catch(Exception excp){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid query')); 
            return null;
        }
        return sObjectList;
    }
    public List<sObject> getDisplayFields(String query){
        List<sObject> records = executeQuery(query);
        if(records == null){
            return null;
        }
        else{
            if(records.isEmpty()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No record found'));
                records = null;
            }
            else{
                fieldsApiNameList = new List<String>();
                fieldsApiNameList.addAll(records[0].getPopulatedFieldsAsMap().keySet());
            }
            return records; 
        }
    }  
    public void jumpToPage(){
        setCon.setPageNumber(desiredPage);
    }
}