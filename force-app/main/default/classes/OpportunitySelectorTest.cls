@IsTest 
private class OpportunitySelectorTest { 
    // 🏆 Classe de test pour vérifier que OpportunitySelector fonctionne correctement

    //private static Id testAccountId; 
    // Variable pour stocker l'ID du compte de test

    // @TestSetup 
    // static void setup() { 
    //     // ⚙️ Préparation des données de test
    //     // 🔹 Étape 1 : Créer et insérer un compte de test
    //     Account testAccount = TestDataFactory.createTestAccount(); 
    //     // Appelle une méthode de fabrique qui crée un compte de test et l'insert
    //     insert testAccount;

    //     //testAccountId = testAccount.Id; 
    //     // Stocke l'ID du compte pour le réutiliser dans le test

    //     // 🔹 Étape 2 : Créer et insérer 2 opportunités liées à ce compte
    //     List<Opportunity> testOpportunities = TestDataFactory.createTestOpportunities(testAccount.Id, 2); 
    //     // Crée 2 opportunités associées à ce compte et les insère dans la base de données (pendant les tests)
    //     insert testOpportunities;
        
    // }

    @IsTest 
    static void testGetOpportunitiesByAccountId() { 
        // 🎯 Test principal : Vérifie si la méthode retourne les bonnes opportunités
        Account testAccount = TestDataFactory.createTestAccount();
        insert testAccount;

        List<Opportunity> testOpportunities = TestDataFactory.createTestOpportunities(testAccount.Id, 2);
        insert testOpportunities;

        Test.startTest(); 
        // ⏳ Démarre le contexte de test (permet d’exécuter la méthode en conditions réelles)

        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(testAccount.Id); 
        // 🔍 Appelle la méthode que l'on veut tester

        Test.stopTest(); 
        // ⏹️ Arrête le contexte de test

        // ✅ Vérifications (Assertions)
        System.assertNotEquals(0, results.size(), 'Should return at least one opportunity'); 
        // Vérifie que la liste contient au moins une opportunité

        System.assertEquals(2, results.size(), 'Should return exactly two opportunity'); 
        // Vérifie qu'on a exactement 2 opportunités (puisqu'on en a inséré 2)
    }

    @IsTest 
    static void testGetZeroOpportunitiesByAccountId() { 
        // 🎯 Test principal : Vérifie si la méthode retourne les bonnes opportunités
        Account testAccount = TestDataFactory.createTestAccount();
        insert testAccount;

        Test.startTest(); 
        // ⏳ Démarre le contexte de test (permet d’exécuter la méthode en conditions réelles)

        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(testAccount.Id); 
        // 🔍 Appelle la méthode que l'on veut tester

        Test.stopTest(); 
        // ⏹️ Arrête le contexte de test

        // ✅ Vérifications (Assertions)
        System.assertEquals(0, results.size(), 'Should return zero opportunity'); 
        // Vérifie que la liste contient au moins une opportunité

    }

    
     @IsTest 
    static void testGetOpportunitiesByAccountIdWithNullId() { 
        // 🎯 Test principal : Vérifie si la méthode retourne les bonnes opportunités

        Test.startTest(); 
        // ⏳ Démarre le contexte de test (permet d’exécuter la méthode en conditions réelles)

        List<Opportunity> results = OpportunitySelector.getOpportunitiesByAccountId(null); 
        // 🔍 Appelle la méthode que l'on veut tester

        Test.stopTest(); 
        // ⏹️ Arrête le contexte de test

        // ✅ Vérifications (Assertions)
        System.assertEquals(0, results.size(), 'Should return zero opportunity'); 
        // Vérifie que la liste contient au moins une opportunité

    }
    // @IsTest 
    // static void testGetOpportunitiesByAccountIdWithNullId() { 
    //     // 🎯 Test pour vérifier le comportement quand l'ID est null

    //     try { 
    //         Test.startTest(); 
    //         // ⏳ Démarre le contexte de test

    //         OpportunitySelector.getOpportunitiesByAccountId(null); 
    //         // 🔍 Appelle la méthode avec un ID null (ce qui devrait provoquer une exception)

    //         Test.stopTest(); 
    //         // ⏹️ Arrête le contexte de test

    //         System.assert(false, 'Expected an exception but did not get one'); 
    //         // ❌ Si aucune exception n’est levée, le test échoue
    //     } catch (AuraHandledException e) { 
    //         // ✅ Si une exception est levée, le test réussit
    //         System.assertEquals('L\'ID du compte ne peut pas être vide.', e.getMessage(), 'Exception message should match');
    //         // Vérifie que le message de l'exception est correct
    //     }
    // }
}
