/**
 * Created by solol on 20.12.2019.
 */

@IsTest
private class AddPrimaryContactTest {

    @TestSetup
    static void setUp(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Acc_NY_' + i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'Acc_CA_' + i, BillingState = 'CA'));
        }
        insert accounts;
    }
    @IsTest
    static void testBehavior() {
        Contact contact = new Contact(LastName = 'test');
        insert contact;
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(contact, 'CA');
        Test.startTest();
        System.enqueueJob(addPrimaryContact);
        Test.stopTest();
        System.assertEquals(50, [SELECT count() FROM Contact
            WHERE AccountId IN (SELECT Id FROM Account WHERE BillingState = 'CA')]);
    }
}