public with sharing class OpportunitySelector { // Classe pour récupérer les opportunités associées à un compte.
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {  // Récupère les opportunités associées à un compte.
        if (accountId == null) { // Si l'ID du compte est nul.
            // Au lieu de lever une exception, retourne simplement une liste vide.
            return new List<Opportunity>(); // Retourne une liste vide si l'ID du compte est nul.
        }

        List<Opportunity> opportunities = [         // Récupère les opportunités associées à un compte.
            SELECT Id, Name, Amount, CloseDate, StageName // Sélectionne les champs de l'opportunité.
            FROM Opportunity // Objet de requête.
            WHERE AccountId = :accountId // Filtre sur l'ID du compte.
            ORDER BY CloseDate DESC // Trie par date de clôture décroissante.
        ];
        return (opportunities != null) ? opportunities : new List<Opportunity>(); // Si la requête SOQL renvoie "null", retourne une liste vide.
    }
}