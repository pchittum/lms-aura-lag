public with sharing class DataFetcher {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Type FROM Account];        
    }

    @RemoteAction
    public static List<Account> getAccountsRemote(){
        return getAccounts();
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accountId){
        return [SELECT Id, Name, FirstName, LastName, Account.Name, Account.Id FROM Contact WHERE AccountId = : accountId];        
    }

    public static void createTestRecords(){

        // todo: snippet for sobject list instantiation
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();

        accounts.add(new Account(Name='Toto, PLC.', Type='Other'));
        accounts.add(new Account(Name='Glad Train', Type='Other'));
        accounts.add(new Account(Name='Froggerzog', Type='Other'));

        insert accounts; 

        contacts.add(new Contact(FirstName='Farley', LastName='Wallop', AccountId=accounts[0].Id));
        contacts.add(new Contact(FirstName='Percy', LastName='Passage', AccountId=accounts[0].Id));
        contacts.add(new Contact(FirstName='Charles', LastName='Catholes', AccountId=accounts[0].Id));
        contacts.add(new Contact(FirstName='Clay', LastName='Bedlam', AccountId=accounts[1].Id));
        contacts.add(new Contact(FirstName='Dean', LastName='Drinkstone', AccountId=accounts[1].Id));
        contacts.add(new Contact(FirstName='Fanny', LastName='Cove', AccountId=accounts[1].Id));
        contacts.add(new Contact(FirstName='Hampton', LastName='Giggleswick', AccountId=accounts[1].Id));
        contacts.add(new Contact(FirstName='Jeffrey', LastName='Horncastle', AccountId=accounts[2].Id));
        contacts.add(new Contact(FirstName='Julia', LastName='Splatt', AccountId=accounts[2].Id));
        contacts.add(new Contact(FirstName='Lois', LastName='Weedon', AccountId=accounts[2].Id));
        contacts.add(new Contact(FirstName='Wiley', LastName='Tosside', AccountId=accounts[2].Id));
        contacts.add(new Contact(FirstName='Geraint', LastName='Slackbottom', AccountId=accounts[2].Id));
        
        insert contacts;
    }

    public static void deleteData() {
        
        delete [select Id from Contact];
        delete [select Id from Account];

    }

    public static void refreshData(){
        // delete stuff
        deleteData();

        // re-run creatTestRecords
        createTestRecords();
    }

}
