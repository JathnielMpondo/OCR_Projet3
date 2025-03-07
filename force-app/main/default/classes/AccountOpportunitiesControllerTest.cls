@IsTest // Annotation pour indiquer que la classe est une classe de test
private class AccountOpportunitiesControllerTest { // Classe de test AccountOpportunitiesControllerTest
    private static Id testAccountId; // Variable statique pour stocker l'ID du compte de test

    @TestSetup // Annotation pour indiquer la méthode de configuration
    static void setup() { // Méthode de configuration
        // 1️⃣ Créer et insérer un compte de test
        Account testAccount = TestDataFactory.createTestAccount(); // Créer un compte de test avec TestDataFactory
        insert testAccount; // Insérer le compte dans la base de données avec insert 
        testAccountId = testAccount.Id; // ✅ Stocker l’ID du compte créé pour les tests suivants 

        // 2️⃣ Créer et insérer une opportunité liée à ce compte de test 
        Opportunity testOpportunity = TestDataFactory.createTestOpportunity(testAccountId); // Créer une opportunité de test avec TestDataFactory 
        insert testOpportunity; // Insérer l'opportunité dans la base de données avec insert 
    }

    @IsTest // Annotation pour indiquer la méthode de test 
    static void testGetOpportunities() { // Méthode de test 
        Test.startTest(); // Démarrer le contexte de test 
        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(testAccountId); // Appeler la méthode getOpportunities de AccountOpportunitiesController
        Test.stopTest(); // Arrêter le contexte de test 

        System.assertEquals(1, results.size(), 'Should return one opportunity'); // Vérifier que la liste contient exactement une opportunité 
    }
}