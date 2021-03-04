public inherited sharing class Accounts extends fflib_SObjectDomain{
    
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }

    public override void onApplyDefaults() {
        for(Account account : (List<Account>) Records) {
            if(account.Description == null) {
                account.Description = 'Domain classes rock!';
            }               
        }
    }

    public override void onAfterInsert() {

    }

    public override void onAfterUpdate(Map<Id,SObject> oldRecords) {

    }

    public override void onBeforeInsert() {

    }

    public override void onBeforeUpdate(Map<Id,SObject> oldRecords) {

        populateAnnualRevenue(oldRecords);
    }

    private void populateAnnualRevenue(Map<Id,SObject> oldRecords){

        
        for(Account acc : (List<Account>)Records){
            Account oldValue = (Account)oldRecords.get(acc.Id);
            String oldDescription = oldValue.Description;
            acc.AnnualRevenue = (acc.Description).getLevenshteinDistance(oldDescription);
        }
    }
}
