@IsTest 
public class TestDataFactory { 
    // 🏆 Classe de test servant à créer des données fictives pour les tests
    // 🔹 Rend cette méthode accessible aux classes de test
    public static Account createTestAccount() { 
        // 🏗️ Méthode qui crée et retourne un compte de test
        Account acc = new Account(Name = 'Test Account'); 
        // 🔹 Création d'un compte avec un nom "Test Account"
       // insert acc; 
        // 📌 Insère le compte dans la base de données (uniquement pendant les tests)
        return acc; 
        // 🔄 Retourne l'objet compte créé
    }
    
    public static List<Opportunity> createTestOpportunities(Id accountId, Integer nbreOpportunities) { 
        // 🏗️ Méthode qui crée et retourne une opportunité associée à un compte

        // if (accountId == null) { 
        //     // Vérifie que l'ID du compte n'est pas null avant de créer une opportunité
        //     throw new IllegalArgumentException('accountId ne peut pas être null'); 
        //     // Si l'ID est vide, on lève une erreur pour éviter un bug
        // }
        List<Opportunity> opportunities = new List<Opportunity>(); 
        for (Integer i = 0; i< nbreOpportunities; i++) {
            opportunities.add (new Opportunity(
                Name = 'TestOpp'+i ,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                AccountId = accountId,
                Amount = 1000 + i * 100
            ));
        }
       // insert opportunities;
        return opportunities ;
    }

    
    public static List<Case> createTestCases(Id accountId, Integer nbreCases) {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i< nbreCases; i++) {
            cases.add(new Case(
                AccountId = accountId,
                Subject = 'Test Case '+i,
                Status = 'New',
                Priority = 'High'
            ));
        
        }
        insert cases;
        return cases;
    }
}