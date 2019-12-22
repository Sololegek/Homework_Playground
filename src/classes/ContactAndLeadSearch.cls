/**
 * Created by solol on 18.12.2019.
 */

public with sharing class ContactAndLeadSearch {

    public static List<List<SObject>> searchContactsAndLeads(String template){
        return [FIND :template IN NAME FIELDS RETURNING Contact, Lead];
    }
}