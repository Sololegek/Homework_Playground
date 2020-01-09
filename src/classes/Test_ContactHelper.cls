/**
 * Created by solol on 09.01.2020.
 */

@IsTest
public class Test_ContactHelper {

    public static Contact createDummyContact(String lastName, Id accountId, Boolean needInsert){
        Contact contact = new Contact(LastName = lastName, AccountId = accountId);
        if (needInsert){
            insert contact;
        }
        return contact;
    }

    public static List<Contact> createListOfDummyContacts(Integer count, String lastName, Id accountId, Boolean needInsert){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < count; i++) {
            contacts.add(createDummyContact(lastName + '#' + i, accountId, false));
        }
        if (needInsert){
            insert contacts;
        }
        return contacts;
    }
}