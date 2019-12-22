/**
 * Created by solol on 22.12.2019.
 */

public without sharing class AccountTriggerHelper {

    public static void createTask(List<Account> accounts){
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            Task task = new Task(Subject = 'Negotiations with ' + account.Name);
            task.WhatId = account.Id;
            tasks.add(task);
        }
        insert tasks;
    }
}