public class ObjectsList {
    public static list<Schema.SObjectType> listOfObjects(){
        return Schema.getGlobalDescribe().Values();
    }
}