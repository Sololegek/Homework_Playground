/**
 * Created by solol on 09.01.2020.
 */

@IsTest
private class ContactBatchableProcessorTest {

    @TestSetup
    static void setUp(){
        List<Account> accounts = Test_AccountHelper.createListOfDummyAccounts(200, 'batchTest', false, true);
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts){
            Contact contact = Test_ContactHelper.createDummyContact('batchContact', account.Id, false);
            contact.Is_Synced__c = false;
            contacts.add(contact);
            account.BillingStreet = 'dummyStreet';
        }
        insert contacts;
        update accounts;
    }

    @IsTest
    static void testBatch() {
        Test.startTest();
        ContactBatchableProcessor contactBatch = new ContactBatchableProcessor();
        Database.executeBatch(contactBatch);
        Test.stopTest();

        List<String> streets = new List<String>();
        for (Account account : [SELECT BillingStreet FROM Account WHERE Name LIKE 'batchTest%']){
            streets.add(account.BillingStreet);
        }
        System.assertEquals(200, [SELECT COUNT() FROM Contact WHERE MailingStreet IN :streets]);
        System.assertEquals(200, [SELECT COUNT() FROM Contact WHERE Is_Synced__c = TRUE]);
        System.assertEquals(200, [SELECT COUNT() FROM Account WHERE Updated_By_Contact__c = TRUE]);
    }
}