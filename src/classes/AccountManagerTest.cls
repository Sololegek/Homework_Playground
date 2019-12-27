/**
 * Created by solol on 27.12.2019.
 */

@IsTest
private class AccountManagerTest {

    static Id setUp(){
        Account account = new Account(Name = 'Test Acc');
        account.Contacts.add(new Contact(LastName = 'Test Cont'));
        insert account;
        return account.Id;
    }

    @IsTest
    static void testBehavior() {
        Id recordId = setUp();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://brave-otter-ykdwy-dev-ed.salesforce.com/services/apexrest/Accounts/' +
                recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;

        Account actualAccount = AccountManager.getAccount();
        System.assertNotEquals(actualAccount, null);
    }
}