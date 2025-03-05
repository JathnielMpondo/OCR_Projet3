public with sharing class AccountCasesController {
    @AuraEnabled
    public static List<Case> findCasesBySubject(String accountId) {
        return [
            SELECT Id, Subject, Status, Priority 
            FROM Case 
            WHERE AccountId = :accountId)
        ];
    }
}