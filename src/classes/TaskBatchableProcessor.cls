/**
 * Created by solol on 22.12.2019.
 */

public with sharing class TaskBatchableProcessor implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Is_Synced__c, WhatId FROM Task WHERE Is_Synced__c = false');
    }

    public void execute(Database.BatchableContext context, List<Task> tasks) {
        List<Account> accounts = new List<Account>();
        for (Task task : tasks){
            Account account = [SELECT OwnerId, Updated_By_Task__c FROM Account WHERE Id = :task.WhatId];
            User user = [SELECT Name FROM User WHERE Id = :account.OwnerId];
            task.Account_Owner__c = user.Name;
            task.Is_Synced__c = true;
            account.Updated_By_Task__c = true;
            if (!accounts.contains(account)) {
                accounts.add(account);
            }
        }
        update tasks;
        update accounts;
    }

    public void finish(Database.BatchableContext context) {
    }
}