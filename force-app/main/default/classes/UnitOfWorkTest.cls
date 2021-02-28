@isTest
public inherited sharing class UnitOfWorkTest {

    private static List<Schema.SObjectType> MY_SOBJECTS =
        new Schema.SObjectType[] {
            Account.SObjectType,
            Contact.SObjectType,
            Note.SObjectType };

    /*@isTest
    public static void challengeComplete(){

        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(MY_SOBJECTS);

        for(Integer i=0; i<99; i++){
            Account acc = new Account();
            acc.Name = 'Test Account' + i;
            uow.registerNew(acc);

            for(Integer j=0; j<i+400; j++){

                Contact ct = new Contact();
                ct.LastName = 'Test Contact ' + j;
                uow.registerNew(ct);

                Note note = new Note();
                note.Title = 'Test Note ' + j;
                uow.registerNew(note);
            }
        }

        uow.commitWork();

        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }*/
    @isTest
    static void challengeComplete(){

        fflib_sobjectUnitOfWork workUnit = new fflib_sobjectUnitOfWork(new Schema.SObjectType[]{Account.sObjectType, Contact.sObjectType, Note.sObjectType}); 
        for(Integer i= 1; i <= 100; i++){
            Account acc = new Account();
            acc.Name = 'Fanancial'+i;
            workUnit.registerNew(acc);
        }
        
        for(Integer i = 1; i <= 500; i++){

            Contact cont = new Contact();
            cont.LastName = 'LePodium' + i;
            workUnit.registerNew(cont);
            
            Note myNote = new Note();
            myNote.Title = 'Test' + i;
            
            workUnit.registerNew(myNote, Note.ParentId, cont);
        }
        
        test.startTest();
        workUnit.commitWork();
        test.stopTest();
        
        system.assertEquals(100, [SELECT Id FROM Account].size());
        system.assertEquals(500, [SELECT Id FROM Contact].size());
        system.assertEquals(500, [SELECT Id FROM Note].size());
    }
}
