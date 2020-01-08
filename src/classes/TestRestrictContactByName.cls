@isTest
public class TestRestrictContactByName {

    @isTest
    static void testInvalidInsertName(){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 100; i++){
            contacts.add(new Contact(FirstName = 'i=' + i, LastName = 'INVALIDNAME'));
            contacts.add(new Contact(FirstName = 'i=' + i, LastName = 'VALIDNAME'));
        }
        
        Test.startTest();
        Database.SaveResult[] resultList = Database.insert(contacts, false);
        Test.stopTest();
        
        Integer failureCounter = 0;
        for(Database.SaveResult result : resultList){
            if(!result.isSuccess()){
                failureCounter++;
            }
        }
        System.assertEquals(100, failureCounter);
    }
}