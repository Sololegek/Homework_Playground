/**
 * Created by solol on 19.12.2019.
 */

@IsTest
private class AccountProcessorTest {
    @IsTest
    static void testBehavior() {
        Account testAccount = new Account(Name = 'test');
        insert testAccount;
        Id id = testAccount.Id;
        Contact contact = new Contact(LastName = 'test', AccountId = id);
        insert contact;
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{id});
        Test.stopTest();
        Account expectedAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :id];
        System.assert(expectedAccount.Number_of_Contacts__c == 1);
    }
}