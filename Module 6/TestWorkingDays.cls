@isTest
public class TestWorkingDays {

    // Test numberOfWorkingDays function
    @isTest
    static void testNumberOfWorkingDaysPositiveCase(){
        // Create start date and end date
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 10);
        
        // Test the function
        Integer workDays = WorkingDays.numberOfWorkingDays(startDate, endDate);
        
        // Compare actual with expected
        system.assertEquals(5, workDays);
    }
    
    // For same day
    @isTest
    static void testNumberOfWorkingDayWithSameDate(){
        // Create start date and end date
        Date startDate = Date.newInstance(2020, 5, 1);
        Date endDate = Date.newInstance(2020, 5, 1);
        
        // Test the function
        Integer workDays = WorkingDays.numberOfWorkingDays(startDate, endDate);
        
        // Compare actual with expected
        system.assertEquals(0, workDays);
        
    }
    
    // Start date is next to the last date
    @isTest
    static void testNumberOfWorkingDayNegativeCase(){
        // Create start date and end date
        Date startDate = Date.newInstance(2019, 5, 1);
        Date endDate = Date.newInstance(2018, 5, 1);
        
        // Test the function
        Integer workDays = WorkingDays.numberOfWorkingDays(startDate, endDate);
        
        // Compare actual with expected
        system.assertEquals(0, workDays);
        
    }
}