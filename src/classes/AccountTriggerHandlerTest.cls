/**
 * Created by solol on 08.01.2020.
 */

@IsTest
private class AccountTriggerHandlerTest {

    @TestSetup
    static void setUp(){
        List<Account> accounts = Test_AccountHelper.createListOfDummyAccounts(100, 'test', false, false);
        List<Account> overwhelmedAccounts = Test_AccountHelper.createListOfDummyAccounts(100, 'overwhelmedTest', false, false);

        List<Account> allAccounts = new List<Account>();
        allAccounts.addAll(accounts);
        allAccounts.addAll(overwhelmedAccounts);
        insert allAccounts;

        List<Task> tasks = new List<Task>();
        List<Contact> contacts = new List<Contact>();
        for (Account account : overwhelmedAccounts) {
            tasks.addAll(Test_TaskHelper.createListOfDummyTasks(4, 'test', 'Not started', account.Id, false));
        }
        for (Account account : accounts) {
            tasks.addAll(Test_TaskHelper.createListOfDummyTasks(2, 'test', 'Not started', account.Id, false));
            contacts.addAll(Test_ContactHelper.createListOfDummyContacts(3, 'dummyContact', account.Id, false));
        }

        Test.startTest();
        insert tasks;
        insert contacts;
        Test.stopTest();
    }

    @IsTest
    static void testAccountInsert() {
        List<Account> accounts = Test_AccountHelper.createListOfDummyAccounts(200, 'insertTest', false, false);

        Test.startTest();
        insert accounts;
        Test.stopTest();

        List<Task> tasks = [SELECT Subject, WhatId, Is_Synced__c FROM Task WHERE Subject LIKE 'Negotiations with insertTest%'];
        Set<Id> ids = new Set<Id>();
        Boolean Is_Synced = false;
        for (Task task : tasks) {
            ids.add(task.WhatId);
            if (task.Is_Synced__c) {
                Is_Synced = task.Is_Synced__c;
            }
        }

        System.assertEquals(false, Is_Synced);
        System.assertEquals(200, ids.size());
        System.assertEquals(200, tasks.size());
    }

    @IsTest
    static void testReassigningTasksAccountUpdate(){
        List<Account> accounts = getAccounts('test');
        accounts.addAll(getAccounts('overwhelmedTest'));

        System.debug(accounts.size());

        Test.startTest();
        update accounts;
        Test.stopTest();

        Id id = [SELECT Id FROM User WHERE Name = 'Aleh Salavei'].Id;
        List<Task> updatedTasks = [SELECT Subject FROM Task WHERE OwnerId != :id];
        System.assertEquals(500, updatedTasks.size()); //there are 100 accounts with 4 tasks added in testSetup and 1 extra task added by Account afterInsert trigger
    }

    @IsTest
    static void testChangingAddressAccountUpdate(){
        List<Account> accounts = getAccounts('test');

        Test.startTest();
        for (Integer i = 0; i < 50; i++) {
            accounts[i].BillingStreet = 'DummyStreet';
        }
        Database.SaveResult[] result = Database.update(accounts);
        Test.stopTest();

        System.assertEquals(100, result.size());
        List<Contact> updatedByFutureContacts = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, updatedByFutureContacts.size());
        List<Contact> updatedByQueueContacts = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(150, updatedByQueueContacts.size());
    }

    static List<Account> getAccounts(String name){
        return [SELECT Id FROM Account WHERE Name LIKE :name + '%'];
    }
}