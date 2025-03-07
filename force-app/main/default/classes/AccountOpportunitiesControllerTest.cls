@IsTest // Annotation pour indiquer que la classe est une classe de test
private class AccountOpportunitiesControllerTest { // Classe de test AccountOpportunitiesControllerTest
    @TestSetup // Annotation pour indiquer la méthode de configuration
    static void setup() { // Méthode de configuration
        Account testAccount = TestDataFactory.createTestAccount();
        TestDataFactory.createTestOpportunity(testAccount.Id);
    }

    @IsTest // Annotation pour indiquer la méthode de test
    static void testGetOpportunities() { // Méthode de test
        Account testAccount = [SELECT Id FROM Account LIMIT 1]; // Sélectionner un compte de test
        Test.startTest(); // Démarrer le contexte de test
        List<Opportunity> results = AccountOpportunitiesController.getOpportunities(testAccount.Id); // Appeler la méthode getOpportunities
        Test.stopTest(); // Arrêter le contexte de test
        Assert.areEqual(1, results.size(), 'Should return one opportunity'); // Vérifier qu'une opportunité est retournée (taille de la liste = 1); La bonne syntaxe est System.assertEquals()
    }
}