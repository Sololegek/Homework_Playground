/**
 * Created by solol on 08.01.2020.
 */

@IsTest
private class TaskTriggerHandlerTest {

    private final static String STATUS_COMPLETED = 'Completed';
    private final static String STATUS_NOT_COMPLETED = 'Not Started';

    @TestSetup
    static void setUp() {
        List<Account> accounts = Test_AccountHelper.createListOfDummyAccounts(4, 'test', false, true);
        Test_TaskHelper.createListOfDummyTasks(1, 'test', STATUS_NOT_COMPLETED, accounts[0].Id, true);
        Test_TaskHelper.createListOfDummyTasks(1, 'test', STATUS_NOT_COMPLETED, accounts[1].Id, true);
        Test_TaskHelper.createListOfDummyTasks(1, 'test', STATUS_NOT_COMPLETED, accounts[2].Id, true);
        Test_TaskHelper.createListOfDummyTasks(1, 'test', STATUS_COMPLETED, accounts[3].Id, true);
    }

    @IsTest
    static void testTaskUpdate() {
        List<Task> tasks = getTasks();
        List<Id> ids = new List<Id>();
        for (Task task : tasks){
            ids.add(task.WhatId);
            task.Status = STATUS_COMPLETED;
        }

        Test.startTest();
        update tasks;
        Test.stopTest();

        List<Account> accounts = [SELECT Plans_Discussed__c FROM Account WHERE Plans_Discussed__c = TRUE];
        System.assertEquals(3, accounts.size());
    }

    private static List<Task> getTasks(){
        return [SELECT Status, Subject, WhatId FROM Task WHERE Subject LIKE 'test%'];
    }
}