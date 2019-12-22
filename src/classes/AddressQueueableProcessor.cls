/**
 * Created by solol on 22.12.2019.
 */

public with sharing class AddressQueueableProcessor implements Queueable{

    private List<Id> ids;

    public AddressQueueableProcessor(List<Id> ids){
        this.ids = ids;
    }

    public void execute(QueueableContext context) {
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Queue__c FROM Contact WHERE AccountId in :ids];
        for (Contact contact : contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Queue__c = true;
        }
        update contacts;
    }


}