/**
 * Created by solol on 22.12.2019.
 */

public without sharing class TaskTriggerHandler {

    public static Boolean runFlag = true;

    public static void onAfterUpdate(Map<Id,Task> oldMap, Map<Id,Task> newMap){
        if (newMap != null && oldMap != null) {
            TaskTriggerHelper.changeStatus(oldMap, newMap);
        }
    }
}