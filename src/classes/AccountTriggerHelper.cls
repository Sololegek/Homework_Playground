/**
 * Created by solol on 22.12.2019.
 */

public without sharing class AccountTriggerHelper {

    public static void createTask(Set<Id> ids){
        if (ids != null) {
            createFutureTasks(ids);
        }
    }

    @Future
    private static void createFutureTasks(Set<Id> ids){
        if (ids != null) {
            List<Account> accounts = [SELECT Name FROM Account WHERE Id IN :ids];
            if (!accounts.isEmpty()) {
                List<Task> tasks = new List<Task>();
                for (Account account : accounts) {
                    Task task = new Task(Subject = 'Negotiations with ' + account.Name);
                    task.WhatId = account.Id;
                    task.Is_Synced__c = false;
                    tasks.add(task);
                }
                if (!tasks.isEmpty()) {
                    insert tasks;
                }
            }
        }
    }

    public static void reassignTasks(Map<Id, Account> newMap){
        if (newMap != null) {
            List<Account> accounts = [SELECT Id, Name, (SELECT WhatId, OwnerId FROM Tasks) FROM Account WHERE Id IN :newMap.keySet()];
            User user = [SELECT Id, LastName FROM User WHERE IsActive = TRUE AND Name != 'Aleh Salavei' LIMIT 1];
            if(!accounts.isEmpty() && user != null) {
                List<Task> tasks = new List<Task>();
                for (Account account : accounts) {
                    if (account.Tasks.size() > 3) {
                        for (Task task : account.Tasks) {
                            task.OwnerId = user.Id;
                            tasks.add(task);
                        }
                    }
                }
                if (!tasks.isEmpty()) {
                    update tasks;
                }
            }
        }
    }

    public static void updateAddress(Map<Id, Account> oldMap, Map<Id, Account> newMap){
        if (oldMap != null && newMap != null) {
            List<Id> ids = new List<Id>();
            if (!newMap.isEmpty()) {
                for (Account account : newMap.values()) {
                    Account oldAccount = oldMap.get(account.id);
                    if (account.BillingStreet != oldAccount.BillingStreet ||
                            account.BillingCity != oldAccount.BillingCity ||
                            account.BillingState != oldAccount.BillingState ||
                            account.BillingCountry != oldAccount.BillingCountry ||
                            account.BillingPostalCode != oldAccount.BillingPostalCode) {
                        ids.add(account.id);
                    }
                }
            }
            if (!ids.isEmpty()) {
                updateFutureAddress(ids);
                AddressQueueableProcessor addressQueueableProcessor = new AddressQueueableProcessor(ids);
                System.enqueueJob(addressQueueableProcessor);
            }
        }
    }

    @Future
    private static void updateFutureAddress(List<Id> ids) {
        if (ids != null) {
            List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :ids];
            if (!contacts.isEmpty()) {
                for (Contact contact : contacts) {
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Future__c = true;
                }
                update contacts;
            }
        }
    }
}