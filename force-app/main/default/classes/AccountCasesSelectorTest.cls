@isTest
private class AccountCasesSelectorTest { // 1. On crée une classe de test AccountCasesSelectorTest

    @isTest static void testGetCasesByAccountIdAndSubject() {
        // On crée un faux compte pour faire nos tests
        Account testAccount = new Account(Name = 'Test Account'); // On crée un compte avec un nom "Test Account" (nom fictif) 
        insert testAccount; // On insère le compte dans la base

        // On crée deux faux cas rattachés à ce compte
        Case case1 = new Case( // On crée un cas avec un sujet "Problème de facturation" (facturation = billing en anglais) et une priorité haute (High) 
            AccountId = testAccount.Id, // On lie le cas au compte créé précédemment 
            Subject = 'Problème de facturation', // On donne un sujet au cas (facturation = billing en anglais) 
            Status = 'New', // On donne un statut "Nouveau" au cas (New = New en anglais) 
            Priority = 'High' // On donne une priorité "Haute" au cas (High = High en anglais) 
        );
        Case case2 = new Case( // On crée un cas avec un sujet "Erreur technique" et une priorité basse (Low) 
            AccountId = testAccount.Id, // On lie le cas au compte créé précédemment 
            Subject = 'Erreur technique', // On donne un sujet au cas (Erreur technique = technical error en anglais)
            Status = 'Low', // On donne un statut "Basse" au cas (Low = Low en anglais) 
            Priority = 'Low' // On donne une priorité "Basse" au cas (Low = Low en anglais) 
        );

        insert new List<Case>{ case1, case2 }; // On insère les deux cas dans la base de données 
        // 1. Test : recherche avec "facturation" (doit trouver case1) 
        List<Case> result1 = AccountCasesSelector.getCasesByAccountIdAndSubject('facturation', testAccount.Id); // On appelle la méthode de recherche avec le sujet "facturation" et l'ID du compte créé précédemment 

        // On vérifie qu'on a bien trouvé 1 cas
        System.assertEquals(1, result1.size(), 'On doit trouver 1 cas correspondant à "facturation"'); // On vérifie que le résultat de la recherche contient bien 1 cas 
        // On vérifie que c’est bien le bon sujet
        System.assertEquals('Problème de facturation', result1[0].Subject); // On vérifie que le sujet du cas trouvé est bien "Problème de facturation" 

        // 2. Test : recherche avec un mot qui ne matche aucun sujet
        List<Case> result2 = AccountCasesSelector.getCasesByAccountIdAndSubject('inexistant', testAccount.Id); // On appelle la méthode de recherche avec un sujet qui ne correspond à aucun cas 

        // On doit avoir 0 résultat
        System.assertEquals(0, result2.size(), 'On ne doit rien trouver avec un sujet inexistant'); // On vérifie que le résultat de la recherche est vide

        // 3. Test : recherche avec un subjectSearchTerm vide (doit retourner tous les cas du compte)
        List<Case> result3 = AccountCasesSelector.getCasesByAccountIdAndSubject('', testAccount.Id); // On appelle la méthode de recherche avec un sujet vide

        // Comme on n'a pas filtré sur le sujet, on devrait retrouver les 2 cas
        System.assertEquals(2, result3.size(), 'Sans filtre sur le sujet, on devrait récupérer tous les cas du compte'); // On vérifie que le résultat de la recherche contient bien 2 cas

        // 4. Test : ID de compte nul
        List<Case> result4 = AccountCasesSelector.getCasesByAccountIdAndSubject('facturation', null); // On appelle la méthode de recherche avec un ID de compte nul

        // Si pas de compte, on doit avoir une liste vide
        System.assertEquals(0, result4.size(), 'Quand le compte est nul, on doit retourner une liste vide'); // On vérifie que le résultat de la recherche est vide
    }
}