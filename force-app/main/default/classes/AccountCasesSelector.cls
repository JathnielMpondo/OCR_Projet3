public with sharing class AccountCasesSelector {
    
    // Méthode publique et statique qui retourne une liste de cas en fonction d'un compte et d'un sujet
    public static List<Case> getCasesByAccountIdAndSubject(String subjectSearchTerm, Id accountId) {

        // Prépare la recherche en ajoutant % avant et après pour faire une recherche partielle sur le sujet
        String searchTerm = '%' + subjectSearchTerm + '%';    

        // Si l'ID du compte est nul (vide), on renvoie directement une liste vide
        if (accountId == null) {
            return new List<Case>();
        }

        // On exécute la requête SOQL pour chercher les cas
        List<Case> cases = [
            SELECT Id, Subject, Status, Priority, Origin, Type, Reason, Description // Les colonnes qu'on veut récupérer
            FROM Case // L'objet sur lequel on fait la recherche
            WHERE AccountId = :accountId // On filtre uniquement les cas liés à ce compte
            AND Subject LIKE :searchTerm // On filtre sur le sujet qui contient le texte recherché
            ORDER BY Priority DESC // On trie les cas par priorité décroissante (Haute > Moyenne > Basse)
        ];

        // Si on trouve des cas, on les retourne. Sinon, on renvoie une liste vide (par sécurité)
        return (cases != null) ? cases : new List<Case>();
    }
}