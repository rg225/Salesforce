public class WorkingDays {

    /**
     *  
     *  A function which take two dates as argument 
     *  @param startdate and lastdate
     *  @return number of working days between two dates. 
     *  Condition excluding both days. (Saturday and Sunday is non-working days)
     */
    public static Integer numberOfWorkingDays(Date startDate, Date lastDate){
        // Calculating the number of days between start and last date 
        // to exclude the both days deduct 1 from result because it give result including end day.
        Integer totalDays = startDate.daysBetween(lastDate) - 1;
        

        // To find the day of week in the start date
        Datetime start = DateTime.newInstance(startDate, Time.newInstance(0, 0, 0, 0));
		String startDay = start.format('EEEE');
        
        // To find the day of week in the last date
        Datetime last = DateTime.newInstance(lastDate, Time.newInstance(0, 0, 0, 0));
		String lastDay = last.format('EEEE');
        
        /**
         * If start date is saturday then next day is sunday which is included in the total days
         * so we just -1 to remove that day from total work days similarly for friday we just -2 
         * because saturday and sunday are included.
         */
        if(startDay == 'Saturday'){
            totalDays -= 1;
        }
        if(startDay == 'Friday'){
            totalDays -= 2;
        }
        /**
         * Similarly we will do for the last day
         */
        if(lastDay == 'Sunday'){
            totalDays -= 1;
        }
        if(lastDay == 'Monday'){
            totalDays -= 2;
        }
        // now we can calculate the holidays by dividing the total days by 7 and multiply it with 2
        // because of Saturday and the Sunday
        Integer holidays = (totalDays/7);
        holidays = holidays * 2;
        Return totalDays - holidays;
    }
}