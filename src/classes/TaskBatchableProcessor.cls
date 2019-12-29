/**
 * Created by solol on 22.12.2019.
 */

public with sharing class TaskBatchableProcessor implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Is_Synced__c, WhatId FROM Task WHERE Is_Synced__c = false');
    }

    public void execute(Database.BatchableContext context, List<Task> tasks) {
        if (tasks != null && !tasks.isEmpty()) {
            Set<Id> ids = new Set<Id>();
            for (Task task : tasks) {
                ids.add(task.WhatId);
            }
            if (!ids.isEmpty()) {
                List<Account> accounts = [SELECT Owner.Name, Updated_By_Task__c FROM Account WHERE Id IN :ids];
                if (!accounts.isEmpty()) {
                    Map<Id, Account> accountMap = new Map<Id, Account>();
                    for (Account account : accounts){
                        accountMap.put(account.Id, account);
                    }
                    for (Task task : tasks) {
                        task.Account_Owner__c = accountMap.get(task.WhatId).Owner.Name;
                        task.Is_Synced__c = true;
                        accountMap.get(task.WhatId).Updated_By_Task__c = true;
                    }
                    update tasks;
                    update accountMap.values();
                }
            }
        }

    }

    public void finish(Database.BatchableContext context) {
    }
}