@IsTest // Annotation pour indiquer que la classe est une classe de test
private class OpportunitySelectorTest { // Classe de test OpportunitySelectorTest
    private static Id testAccountId; // Variable statique pour stocker l'ID du compte de test

    @TestSetup // Annotation pour indiquer la méthode de configuration
    static void setup() { // Méthode de configuration
        // 1️⃣ Créer et insérer un compte
        Account testAccount = TestDataFactory.createTestAccount(); // Créer un compte de test
        insert testAccount; // Insérer le compte
        testAccountId = testAccount.Id; // Stocker l'ID

        // 2️⃣ Créer et insérer une opportunité liée à ce compte
        Opportunity testOpportunity = TestDataFactory.createTestOpportunity(testAccountId); // Créer une opportunité de test
        insert testOpportunity;
    }

    @IsTest // Annotation pour indiquer la méthode de test
    static void testGetOpportunitiesByAccountId() { // Méthode de test
        Test.startTest(); // Démarrer le contexte de test
        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(testAccountId); // Appeler la méthode de sélection des opportunités
        Test.stopTest(); // Arrêter le contexte de test

        System.assertNotEquals(0, results.size(), 'Should return at least one opportunity'); // Vérifier que la liste n'est pas vide
        System.assertEquals(1, results.size(), 'Should return exactly one opportunity'); // Vérifier qu'il y a exactement une opportunité
    }
}
