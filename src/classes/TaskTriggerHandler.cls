/**
 * Created by solol on 22.12.2019.
 */

public without sharing class TaskTriggerHandler {

    public static void onAfterUpdate(Map<Id,Task> oldMap, Map<Id,Task> newMap){
        TaskTriggerHelper.changeStatus(oldMap, newMap);
    }
}