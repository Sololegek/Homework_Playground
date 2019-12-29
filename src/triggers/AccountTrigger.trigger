/**
 * Created by solol on 22.12.2019.
 */

trigger AccountTrigger on Account (after insert, after update) {

    if (AccountTriggerHandler.runFlag) {
        AccountTriggerHandler.runFlag = false;
        if (Trigger.isInsert && Trigger.isAfter) {
            AccountTriggerHandler.onAfterInsert(Trigger.newMap);
        } else if (Trigger.isUpdate && Trigger.isAfter) {
            AccountTriggerHandler.onAfterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
}