public with sharing class AccountOpportunitiesController { // Implémente la logique métier pour le composant LWC "accountOpportunities".
    @AuraEnabled(Cacheable=true) // Permet de mettre en cache les résultats de cette méthode.
    public static List<Opportunity> getOpportunities(Id accountId) { // Retourne une liste d'opportunités pour un compte donné.
        
        if (accountId == null) { // Vérifie si "accountId" est null.
            // Au lieu de lever une exception, retourne simplement une liste vide.
            return new List<Opportunity>(); // Retourne une liste vide si "accountId" est null.
        }
        List<Opportunity> opportunities = OpportunitySelector.getOpportunitiesByAccountId(accountId); // Récupère les opportunités pour un compte donné. 
        return (opportunities != null) ? opportunities : new List<Opportunity>(); // Retourne les opportunités si elles existent.
        // Si "opportunities" est null, retourne une liste vide.
    }
}