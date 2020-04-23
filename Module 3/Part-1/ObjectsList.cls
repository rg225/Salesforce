public class ObjectsList {
    // A function which return the list of sobjects exists in org.
    public static list<Schema.SObjectType> listOfObjects(){
        return Schema.getGlobalDescribe().Values();
    }
}