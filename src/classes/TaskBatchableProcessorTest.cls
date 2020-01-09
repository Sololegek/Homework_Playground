/**
 * Created by solol on 09.01.2020.
 */

@IsTest
private class TaskBatchableProcessorTest {

    @TestSetup
    static void setUp(){
        Test_AccountHelper.createListOfDummyAccounts(200, 'batchTest', false, true);
    }

    @IsTest
    static void testBatch() {
        Test.startTest();
        TaskBatchableProcessor taskBatch = new TaskBatchableProcessor();
        Database.executeBatch(taskBatch);
        Test.stopTest();

        List<String> owners = new List<String>();
        for (Account account : [SELECT Owner.Name FROM Account WHERE Name LIKE 'batchTest%']){
            owners.add(account.Owner.Name);
        }
        System.assertEquals(200, [SELECT COUNT() FROM Task WHERE Account_Owner__c IN :owners]);
        System.assertEquals(200, [SELECT COUNT() FROM Task WHERE Is_Synced__c = TRUE]);
        System.assertEquals(200, [SELECT COUNT() FROM Account WHERE Updated_By_Task__c = TRUE]);
    }
}