@IsTest // Annotation pour indiquer que la classe est une classe de test
private class AccountOpportunitiesControllerTest { // Classe de test AccountOpportunitiesControllerTest


    @TestSetup // Annotation pour indiquer la méthode de configuration
    static void setup() { // Méthode de configuration
        // 1️⃣ Créer et insérer un compte de test
        Account testAccount = TestDataFactory.createTestAccount(); // Créer un compte de test avec TestDataFactory
        insert testAccount; // Insérer le compte dans la base de données avec insert 

        

        // 2️⃣ Créer et insérer 2 opportunités liées à ce compte de test 
        List<Opportunity> testOpportunities = TestDataFactory.createTestOpportunities(testAccount.Id, 2); // Créer 2 opportunités de test avec TestDataFactory 
       insert testOpportunities;
    }

    @IsTest // Annotation pour indiquer la méthode de test 
    
    static void testGetOpportunities() { // Méthode de test 
        Account testAccount = [SELECT Id from Account WHERE Name = 'Test Account']; 
        
        Test.startTest(); // Démarrer le contexte de test 
        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(testAccount.Id); // Appeler la méthode getOpportunities de AccountOpportunitiesController
        Test.stopTest(); // Arrêter le contexte de test 

        System.assertEquals(2, results.size(), 'Should return two opportunity'); // Vérifier que la liste contient exactement une opportunité 
    }
    
     @IsTest 
    static void testGetOpportunitiesByAccountIdWithNullId() { 
        // 🎯 Test principal : Vérifie si la méthode retourne les bonnes opportunités

        Test.startTest(); 
        // ⏳ Démarre le contexte de test (permet d’exécuter la méthode en conditions réelles)

        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(null); 
        // 🔍 Appelle la méthode que l'on veut tester

        Test.stopTest(); 
        // ⏹️ Arrête le contexte de test

        // ✅ Vérifications (Assertions)
        System.assertEquals(0, results.size(), 'Should return zero opportunity'); 
        // Vérifie que la liste contient au moins une opportunité


    }
}