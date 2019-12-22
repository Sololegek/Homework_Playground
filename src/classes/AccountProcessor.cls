/**
 * Created by solol on 19.12.2019.
 */

public with sharing class AccountProcessor {

    @Future
    public static void countContacts(List<Id> ids){
        List<Account> accounts = [SELECT Name, Number_of_Contacts__c, (SELECT LastName FROM Contacts) FROM Account WHERE Id in :ids];
        for (Account account: accounts){
            account.Number_of_Contacts__c = account.Contacts.size();
        }
        update accounts;
    }

}