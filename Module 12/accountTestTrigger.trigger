// 1: SOQL is written inside the for loop
// 2: Query Syntex is in lower case
// 3: Nested loop is used
// 4: DML is used inside the loop

trigger accountTestTrigger on Account (before insert, before update) {
    
    // To store new map key's which is Id 
    Set<Id> actId = Trigger.newMap.keySet();
    
    // Fetch contact related to those Id's
    List<Contact> contacts = [SELECT Id, Salutation, FirstName, LastName, Email	FROM Contact WHERE AccountId IN : actId];
    
    // Iterate the contacts
    for(Contact c: contacts) {
		System.debug('Contact Id[' + c.Id + '], FirstName['+ c.firstname + '],	LastName[' + c.lastname +']');
        c.Description = c.salutation + ' ' + c.firstName + ' ' + c.lastname;
	}
    update contacts;
}
