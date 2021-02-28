public inherited sharing class CaseService {

    public static void closeCases(Set<Id> caseIds, String reason){
        
        if(caseIds == null || caseIds.size() == 0){
            throw new CaseServiceException('Cases not specified!');
        }

        if(reason == null || String.isBlank(reason)){
            throw new CaseServiceException('Invalid reason!');
        }

        List<Case> cases = [SELECT Id, Reason, Status from Case WHERE Id IN :caseIds];

        List<Case> casesToUpdate = new List<Case> ();

        for(Case cs : cases){
            if(cs.Status != 'Closed'){
                cs.Status = 'Closed';
                cs.Reason = reason;

                casesToUpdate.add(cs);
            }
        }

        Savepoint sp = Database.setSavePoint();

        try{
            update casesToUpdate;
        }catch(Exception e){
            Database.rollback(sp);
            throw e;
        }
    }

    public class CaseServiceException extends Exception {} 
}