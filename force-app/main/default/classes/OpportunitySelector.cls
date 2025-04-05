public with sharing class OpportunitySelector {
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        // Vérifier si l'ID du compte est valide
        if (accountId == null) {
            throw new AuraHandledException('L'ID du compte ne peut pas être vide.'); // Lancer une exception AuraHandledException
        }
        // Requête SOQL sécurisée et optimisée
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, CloseDate, StageName // Sélectionner les champs Id, Name, Amount, CloseDate et StageName
            FROM Opportunity // Depuis l'objet Opportunity
            WHERE AccountId = :accountId // Filtrer par ID de compte
            ORDER BY CloseDate DESC // Trier par date de clôture la plus récente
        ];
        return opportunities; 
    }
}
