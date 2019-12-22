/**
 * Created by solol on 20.12.2019.
 */

public with sharing class LeadProcessor implements Database.Batchable<Lead> {


    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext context, List<Lead> leads) {
        for (Lead lead: leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('Batch finished');
    }

}