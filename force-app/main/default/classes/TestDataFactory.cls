@IsTest // Annotation pour indiquer que la classe est une classe de test
public class TestDataFactory { // Classe de test TestDataFactory
    public static Account createTestAccount() { // Méthode statique pour créer un compte de test
        Account acc = new Account(Name='Test Account'); // Créer un nouvel enregistrement de compte avec le nom 'Test Account'
        insert acc; // Insérer le compte dans la base de données
        return acc; // Retourner le compte créé
    }

    public static Opportunity createTestOpportunity(Id accountId) { // Ajouter un paramètre accountId de type Id
        if (accountId == null) {
            throw new IllegalArgumentException('L'ID du compte ne peut pas être null.'); // Lancer une exception si l'ID du compte est null
        }
        Opportunity opp = new Opportunity( // Créer une nouvelle opportunité avec les champs spécifiés
                Name='Test Opportunity',
                StageName='Prospecting',
                CloseDate=System.today().addDays(30),
                Amount=10000,
                AccountId=accountId
        );
        insert opp; // Insérer l'opportunité dans la base de données
        return opp; // Retourner l'opportunité créée
    }
}