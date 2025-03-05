public with sharing class AccountOpportunitiesController {
    @AuraEnabled(Cacheable=true)
    public static List<Opportunity> getOpportunities(Id accountId) {
        if (accountId == null) {
            throw new AuraHandledException("L'ID du compte ne peut pas être vide.");
        }
        return OpportunitySelector.getOpportunitiesByAccountId(accountId);
    }