/**
 * Created by solol on 22.12.2019.
 */

public without sharing class AccountTriggerHandler {

    public static void onAfterInsert(List<Account> accounts){
        AccountTriggerHelper.createTask(accounts);
    }
}