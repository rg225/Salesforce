trigger accountLimitExample on Account (after delete, after insert, after update) {


	System.debug('Total Number of SOQL Queries allowed in this Apex code context: ' + Limits.getLimitQueries());
	System.debug('Total Number of records that can be queried in this Apex code context: ' + Limits.getLimitQueryRows());
	System.debug('Total Number of DML statements allowed in this Apex code context: ' + Limits.getLimitDmlStatements() );
	System.debug('Total Number of CPU usage time (in ms) allowed in this Apex code context: ' + Limits.getLimitCpuTime());

	// Query the Opportunity object
	List<Opportunity> opptys = [SELECT Id, Description, Name, AccountId, CloseDate, StageName FROM Opportunity WHERE AccountId IN:
    Trigger.newMap.keySet()];
    
    System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
    System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getQueryRows());
	System.debug('3. Number of DML statements used so far: ' + limits.getDmlStatements());
	System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());

	// When there are too many Opportunities to update and avoid governor limits
    if(limits.getDmlRows() + opptys.size() > limits.getLimitDmlRows()){
            for (Account act : Trigger.new) {
                act.addError('Limit exceed.');
            }
    }
    else{
        System.debug('Continue processing. Not going to hit DML governor limits');
        System.debug('Going to update ' + opptys.size() + ' opportunities and governor limits will allow ' + limits.getLimitDmlRows());
        
        // Perfrom task on opportunity by Iterate
        for(Account a : Trigger.new){
            System.debug('Number of DML statements used so far: ' + Limits.getDmlStatements());
                for(Opportunity o: opptys){
                    if (o.accountid == a.id)
                        o.description = 'testing';
                }
        }
        update opptys;
    
    System.debug('Final number of DML statements used so far: ' + Limits.getDmlStatements());
    System.debug('Final heap size: ' + limits.getHeapSize());
    }
}