/**
 * Created by solol on 22.12.2019.
 */

public with sharing class ContactBatchableProcessor implements Database.Batchable<Contact> {

    public Iterable<Contact> start(Database.BatchableContext context) {
        return [SELECT AccountId, MailingCity, MailingCountry, MailingStreet, Is_Synced__c FROM Contact WHERE Is_Synced__c = false AND AccountId != null];
    }

    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        if (contacts != null && !contacts.isEmpty()) {
            Set<Id> ids = new Set<Id>();
            for (Contact contact : contacts) {
                ids.add(contact.AccountId);
            }
            if (!ids.isEmpty()) {
                List<Account> accounts = [SELECT BillingCity, BillingCountry, BillingStreet, Updated_By_Contact__c FROM Account WHERE Id IN :ids];
                if (!accounts.isEmpty()) {
                    Map<Id, Account> accountMap = new Map<Id, Account>();
                    for (Account account : accounts) {
                        accountMap.put(account.Id, account);
                    }
                    for (Contact contact : contacts) {
                        Account account = accountMap.get(contact.AccountId);
                        contact.Is_Synced__c = true;
                        contact.MailingStreet = account.BillingStreet;
                        contact.MailingCity = account.BillingCity;
                        contact.MailingCountry = account.BillingCountry;
                        accountMap.get(contact.AccountId).Updated_By_Contact__c = true;
                    }
                    update contacts;
                    update accountMap.values();
                }
            }
        }
    }

    public void finish(Database.BatchableContext context) {
    }

}