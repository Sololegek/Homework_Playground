/**
 * Created by solol on 22.12.2019.
 */

trigger AccountTrigger on Account (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHandler.onAfterInsert(Trigger.new);
    }
}