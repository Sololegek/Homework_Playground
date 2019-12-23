/**
 * Created by solol on 22.12.2019.
 */

public with sharing class ContactBatchableProcessor implements Database.Batchable<Contact> {

    public Iterable<Contact> start(Database.BatchableContext context) {
        return [SELECT AccountId, MailingCity, MailingCountry, MailingStreet, Is_Synced__c FROM Contact WHERE Is_Synced__c = false AND AccountId != null];
    }

    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        List<Account> accounts = new List<Account>();
        for (Contact contact : contacts){
            contact.Is_Synced__c = true;
            Account account = [SELECT BillingCity, BillingCountry, BillingStreet, Updated_By_Contact__c FROM Account WHERE Id = :contact.AccountId];
            contact.MailingStreet = account.BillingStreet;
            contact.MailingCity = account.BillingCity;
            contact.MailingCountry = account.BillingCountry;
            account.Updated_By_Contact__c = true;
            if (!accounts.contains(account)) {
                accounts.add(account);
            }
        }
        update contacts;
        update accounts;
    }

    public void finish(Database.BatchableContext context) {
    }

}