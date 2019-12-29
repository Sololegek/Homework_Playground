/**
 * Created by solol on 22.12.2019.
 */

public without sharing class AccountTriggerHandler {

    public static Boolean runFlag = true;

    public static void onAfterInsert(Map<Id,Account> newMap){
        if (newMap != null) {
            AccountTriggerHelper.createTask(newMap.keySet());
        }
    }

    public static void onAfterUpdate(Map<Id,Account> oldMap, Map<Id,Account> newMap){
        if (newMap != null && oldMap != null) {
            AccountTriggerHelper.reassignTasks(newMap);
            AccountTriggerHelper.updateAddress(oldMap, newMap);
        }
    }
}