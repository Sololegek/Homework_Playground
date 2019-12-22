/**
 * Created by solol on 22.12.2019.
 */

trigger AccountTrigger on Account (after insert, after update) {

    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHandler.onAfterInsert(Trigger.new);
    } else if(Trigger.isUpdate && Trigger.isAfter){
        AccountTriggerHandler.onAfterUpdate(Trigger.new);
    }
}