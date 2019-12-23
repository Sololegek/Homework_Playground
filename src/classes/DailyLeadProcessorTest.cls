/**
 * Created by solol on 23.12.2019.
 */

@IsTest
private class DailyLeadProcessorTest {

    @TestSetup
    static void setUp(){
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Lead ' + i, Company = 'ABC'));
        }
        insert leads;
    }
    @IsTest
    static void testBehavior() {
        Test.startTest();
        DailyLeadProcessor dailyLeadProcessor = new DailyLeadProcessor();
        String cron = '0 0 * * * ?';
        System.schedule('Test Schedule', cron, dailyLeadProcessor);
        Test.stopTest();
        Integer actualCount = [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, actualCount);
    }
}