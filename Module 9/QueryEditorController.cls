public class QueryEditorController {
    public String query{get;set;}
    public Boolean renderQueryTable{get;set;}

    public QueryEditorController(){
        renderQueryTable = false;
    }
    public void executeQuery(){
        if(! String.isBlank(query)){
            renderQueryTable = true;
        }
    }
}