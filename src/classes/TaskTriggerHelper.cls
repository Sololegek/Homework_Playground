/**
 * Created by solol on 22.12.2019.
 */

public without sharing class TaskTriggerHelper {

    private static String STATUS = 'Completed';

    public static void changeStatus(Map<Id, Task> oldMap, Map<Id, Task> newMap){
        if (newMap != null && oldMap != null) {
            List<Id> ids = getChangingTasks(oldMap, newMap);
            if (!ids.isEmpty()) {
                List<Account> accounts = [SELECT Plans_Discussed__c FROM Account WHERE Id IN :ids];
                if (!accounts.isEmpty()) {
                    for (Account account : accounts) {
                        account.Plans_Discussed__c = true;
                    }
                    update accounts;
                }
            }
        }
    }

    private static List<Id> getChangingTasks(Map<Id, Task> oldMap, Map<Id, Task> newMap){
        List<Id> ids = new List<Id>();
        for (Task task : newMap.values()){
            if(task.Status.equals(STATUS)){
                if(!oldMap.get(task.Id).Status.equals(STATUS)){
                    ids.add(task.Id);
                }
            }
        }
        return ids;
    }
}