/**
 * Created by solol on 23.12.2019.
 */

public with sharing class DailyLeadProcessor implements Schedulable{

    public void execute(SchedulableContext param1) {
        List<Lead> leads = [SELECT LeadSource FROM Lead WHERE LeadSource = NULL LIMIT 200];
        for (Lead lead : leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}