@isTest
public class TestVerifyDate {

    static Date currentDate = Date.today();
    static Integer daysInCurrentMonth = Date.daysInMonth(currentDate.year(), currentDate.month());
    static Date currentEndOfMonth = Date.newInstance(currentDate.year(), currentDate.month(), daysInCurrentMonth);
    
    @isTest
    static void testPreviousDate(){
        System.assertEquals(currentEndOfMonth, VerifyDate.CheckDates(currentDate, currentDate.addDays(-1)));
    }
    
    @isTest
    static void testMoreThanRangeDate(){
        System.assertEquals(currentEndOfMonth, VerifyDate.CheckDates(currentDate, currentDate.addDays(30)));
    }
    
    @isTest
    static void testInRangeDate(){
        System.assertEquals(currentDate.addDays(15), VerifyDate.CheckDates(currentDate, currentDate.addDays(15)));
    }
}