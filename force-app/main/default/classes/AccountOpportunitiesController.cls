public with sharing class AccountOpportunitiesController { // classe publique AccountOpportunitiesController
    @AuraEnabled(Cacheable=true) // annotation AuraEnabled avec l'attribut Cacheable=true
    public static List<Opportunity> getOpportunities(Id accountId) { // méthode getOpportunities avec un paramètre accountId de type Id
        if (accountId == null) {
            throw new AuraHandledException("L'ID du compte ne peut pas être vide."); // lancer une exception AuraHandledException
        }
        return OpportunitySelector.getOpportunitiesByAccountId(accountId); // retourner les opportunités associées à l'ID du compte
    }