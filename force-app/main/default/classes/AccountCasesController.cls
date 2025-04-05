public with sharing class AccountCasesController { // classe publique AccountCasesController respectant les règles de partage Salesforce
    @AuraEnabled
    public static List<Case> findCasesBySubject(String accountId) { // méthode findCasesBySubject avec un paramètre accountId de type String
        if (String.isEmpty(accountId)) { // si accountId est vide
            throw new AuraHandledException('L'ID du compte ne peut pas être vide.'); // lancer une exception AuraHandledException
        }

        return [ // retourner une liste de cases
            SELECT Id, Subject, Status, Priority // sélectionner les champs Id, Subject, Status et Priority
            FROM Case // depuis l'objet Case
            WHERE AccountId = :accountId // où AccountId est égal à accountId
        ];
    }
}
