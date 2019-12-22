/**
 * Created by solol on 22.12.2019.
 */

public without sharing class TaskTriggerHelper {

    private static String STATUS = 'Completed';
    public static void changeStatus(Map<Id, Task> oldMap, Map<Id, Task> newMap){
        List<Task> tasks = getChangingTasks(oldMap, newMap);
        List<Account> accounts = new List<Account>();
        for (Task task : tasks){
            Account account = [SELECT Plans_Discussed__c FROM Account WHERE Id = :task.WhatId];
            account.Plans_Discussed__c = true;
            accounts.add(account);
        }
        update accounts;
    }

    private static List<Task> getChangingTasks(Map<Id, Task> oldMap, Map<Id, Task> newMap){
        List<Task> tasks = new List<Task>();
        for (Task task : newMap.values()){
            if(task.Status.equals(STATUS)){
                if(!oldMap.get(task.Id).Status.equals(STATUS)){
                    tasks.add(task);
                }
            }
        }
        return tasks;
    }
}