/**
 * Created by solol on 20.12.2019.
 */

public with sharing class AddPrimaryContact implements Queueable{

    private Contact contact;
    private String state;

    public AddPrimaryContact(Contact contact, String state){
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts){
            Contact primaryContact = contact.clone();
            primaryContact.AccountId = account.Id;
            contacts.add(primaryContact);
        }
        insert contacts;
    }
}