/**
 * Created by solol on 22.12.2019.
 */

trigger TaskTrigger on Task (after update) {

    if (Trigger.isUpdate && Trigger.isAfter) {
        TaskTriggerHandler.onAfterUpdate(Trigger.oldMap, Trigger.newMap);
    }
}