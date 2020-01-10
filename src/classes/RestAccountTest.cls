/**
 * Created by solol on 10.01.2020.
 */

@IsTest
private class RestAccountTest {

    @IsTest
    static void testGet() {
        Account account = Test_AccountHelper.createDummyAccount('GetTest', false, true);

        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/' + account.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Account gottenAccount = RestAccount.getAccount();
        System.assertEquals('GetTest', gottenAccount.Name);
    }

    @IsTest
    static void testPost() {
        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/';
        request.httpMethod = 'POST';
        RestContext.request = request;

        RestAccount.createAccount('GetTest');
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'GetTest']);
    }

    @IsTest
    static void testDelete() {
        Account account = Test_AccountHelper.createDummyAccount('GetTest', false, true);

        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/' + account.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        Id id = account.Id;
        RestAccount.deleteAccount();
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Id = :id]);
    }

    @IsTest
    static void testPatch() {
        Account account = Test_AccountHelper.createDummyAccount('GetTest', false, true);

        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/' + account.Id;
        request.httpMethod = 'PATCH';
        request.requestBody = Blob.valueOf('{"Plans_Discussed__c" : true}');
        RestContext.request = request;

        RestAccount.updateAccountFields();
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'GetTest' AND Plans_Discussed__c = TRUE]);
    }

    @IsTest
    static void testPutUpdate() {
        Account account = Test_AccountHelper.createDummyAccount('GetTest', false, true);

        Id id = account.Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf('{"Name" : "GetTest", "Plans_Discussed__c" : true, "Id" : "' + id + '"}');
        RestContext.request = request;

        RestAccount.upsertAccount();
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'GetTest']);
    }

    @IsTest
    static void testPutInsert() {
        Test_AccountHelper.createDummyAccount('GetTest', false, true);

        RestRequest request = new RestRequest();
        request.requestURI = 'pum.purum/';
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf('{"Name" : "GetTest", "Plans_Discussed__c" : true}');
        RestContext.request = request;

        RestAccount.upsertAccount();
        System.assertEquals(2, [SELECT COUNT() FROM Account WHERE Name = 'GetTest']);
    }
}