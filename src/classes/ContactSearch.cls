/**
 * Created by solol on 18.12.2019.
 */

public with sharing class ContactSearch {

    public static List<Contact> searchForContacts(String lastName, String postalCode){
        return [SELECT Name FROM Contact WHERE (LastName = :lastName AND MailingPostalCode = :postalCode)];
    }
}