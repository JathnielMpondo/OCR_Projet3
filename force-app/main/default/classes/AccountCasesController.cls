public with sharing class AccountCasesController { // Implémente la logique métier pour le composant LWC "accountCases".
    // Déclaration d'une classe publique avec partage activé
    // Cela signifie que les règles de partage Salesforce sont respectées

    @AuraEnabled 
    // Annotation permettant d'utiliser cette méthode dans un composant Lightning

    public static List<Case> findCasesBySubject(String subjectSearchTerm, Id accountId) { 
        // Déclaration d'une méthode publique et statique qui retourne une liste d'objets Case
        // Elle prend un paramètre accountId de type String

        //if (String.isEmpty(accountId)) { 
            // Vérifie si la chaîne accountId est vide

           // throw new AuraHandledException('L\'ID du compte ne peut pas être vide.'); 
            // Si oui, lance une exception qui sera captée dans un composant Lightning
       // }
        return AccountCasesSelector.getCasesByAccountIdAndSubject(subjectSearchTerm, accountId);
        // Appelle la méthode de la classe AccountCasesSelector pour récupérer les cas liés à un compte 
    }
}