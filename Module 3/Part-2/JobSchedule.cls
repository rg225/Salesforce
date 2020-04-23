public class JobSchedule {
    public static void scheduleJob(){
        
        // creating a object of OppOwnerMail class
        OppOwnerMail reminder = new OppOwnerMail();
        
        // Schedule the time
        String cron = '20 30 8 10 2 ?';
        
        // Execute the predefine schedule function
        String jobID = System.schedule('Opportunity Update mail to owner', cron, reminder);
    }
}