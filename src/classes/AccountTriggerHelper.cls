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
}