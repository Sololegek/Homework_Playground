/**
 * Created by solol on 22.12.2019.
 */

public without sharing class AccountTriggerHelper {

    public static void createTask(List<Account> accounts){
        List<Id> ids = new List<Id>();
        for (Account account : accounts) {
            ids.add(account.Id);
        }
        createFutureTasks(ids);
    }

    @Future
    private static void createFutureTasks(List<Id> ids){
        List<Account> accounts = [SELECT Name FROM Account WHERE Id in :ids];
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            Task task = new Task(Subject = 'Negotiations with ' + account.Name);
            task.WhatId = account.Id;
            task.Is_Synced__c = false;
            tasks.add(task);
        }
        insert tasks;
    }

    public static void reassignTasks(List<Account> accounts){
        List<Task> tasks = new List<Task>();
        for (Account account : accounts){
            List<Task> relatedToAccountTasks = new List<Task>();
            relatedToAccountTasks = [SELECT WhatId, OwnerId FROM Task WHERE WhatId = :account.Id];
            if (relatedToAccountTasks.size() > 3) {
                User user = [SELECT Id, LastName FROM User WHERE isActive = true AND Id != :relatedToAccountTasks[0].OwnerId LIMIT 1];
                for (Task task : relatedToAccountTasks){
                    task.OwnerId = user.Id;
                }
                tasks.addAll(relatedToAccountTasks);
            }
        }
        update tasks;
    }

    public static void updateAddress(Map<Id, Account> oldMap, Map<Id, Account> newMap){
        List<Id> ids = new List<Id>();
        for (Account account : newMap.values()){
            Account oldAccount = oldMap.get(account.id);
            if (!account.BillingStreet.equals(oldAccount.BillingStreet) ||
                    !account.BillingCity.equals(oldAccount.BillingCity) ||
                    !account.BillingState.equals(oldAccount.BillingState) ||
                    !account.BillingCountry.equals(oldAccount.BillingCountry) ||
                    !account.BillingPostalCode.equals(oldAccount.BillingPostalCode)){
                ids.add(account.id);
            }
        }
        updateFutureAddress(ids);
        AddressQueueableProcessor addressQueueableProcessor = new AddressQueueableProcessor(ids);
        System.enqueueJob(addressQueueableProcessor);
    }

    @Future
    private static void updateFutureAddress(List<Id> ids){
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId in :ids];
        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        update contacts;
    }
}