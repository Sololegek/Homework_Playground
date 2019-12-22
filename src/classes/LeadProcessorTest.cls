/**
 * Created by solol on 20.12.2019.
 */

@IsTest
private class LeadProcessorTest {

    @TestSetup
    static void setUp(){
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++){
            leads.add(new Lead(LastName = 'test', Company = 'test'));
        }
        insert leads;
    }

    @IsTest
    static void testBehavior() {
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
        Test.stopTest();
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}