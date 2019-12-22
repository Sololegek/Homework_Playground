/**
 * Created by solol on 17.12.2019.
 */

public class AccountHandler {

    public static Account insertNewAccount(String AccountName){
        try{
            Account account = new Account(Name = AccountName);
            insert account;
            return account;
        } catch (DmlException dmlException){
            System.debug('Error occurred: ' + dmlException.getMessage());
            return null;
        }
    }
}