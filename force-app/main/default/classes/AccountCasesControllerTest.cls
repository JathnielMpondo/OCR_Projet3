@isTest
public class AccountCasesControllerTest {

    @isTest 
    public static void testFindCasesBySubject_ValidAccountId() { 
        Account testAccount = new Account(Name = 'Compte Test');
        insert testAccount;

        Case case1 = new Case(
            AccountId = testAccount.Id,
            Subject = 'Problème de livraison',
            Status = 'New',
            Priority = 'High'
        );

        Case case2 = new Case(
            AccountId = testAccount.Id,
            Subject = 'Problème de paiement',
            Status = 'Open',
            Priority = 'Medium'
        );

        insert new List<Case>{ case1, case2 }; 

        Test.startTest();
        List<Case> result = AccountCasesController.findCasesBySubject('', testAccount.Id);
        Test.stopTest();

        System.assertNotEquals(null, result, 'La liste des cas ne doit pas être nulle');
        System.assertEquals(2, result.size(), 'On doit récupérer les 2 cas créés');
        System.assert(result[0].AccountId == testAccount.Id, 'Les cas doivent appartenir au bon compte');
    }

    @isTest 
    public static void testFindCasesBySubject_EmptyAccountId() { 
        try {
            Test.startTest();
            List<Case> result = AccountCasesController.findCasesBySubject('', null);
            Test.stopTest();
            System.assertEquals(0, result.size(), 'Aucun résultat attendu pour un ID null');
        } catch (Exception e) {
            System.assert(false, 'Une exception ne devrait pas être levée, une liste vide est attendue');
        }
    }

    @isTest 
    public static void testFindCasesBySubject_WithSubjectFilter() {
        Account acc = new Account(Name = 'Compte Test');
        insert acc;

        Case case1 = new Case(
            AccountId = acc.Id,
            Subject = 'Support livraison',
            Status = 'New',
            Priority = 'High'
        );

        Case case2 = new Case(
            AccountId = acc.Id,
            Subject = 'Problème technique',
            Status = 'Open',
            Priority = 'Low'
        );

        insert new List<Case>{ case1, case2 };

        Test.startTest();
        List<Case> filtered = AccountCasesController.findCasesBySubject('livraison', acc.Id);
        Test.stopTest();

        System.assertEquals(1, filtered.size(), 'Un seul cas devrait correspondre à "livraison"');
        System.assert(filtered[0].Subject.contains('livraison'), 'Le sujet doit contenir "livraison"');
    }
}