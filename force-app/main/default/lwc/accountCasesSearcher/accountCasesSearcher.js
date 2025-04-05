import { LightningElement, track, api } from 'lwc';
// Importation des modules nécessaires de LWC :
// LightningElement : classe de base pour tous les composants LWC
// track : pour rendre une variable réactive (elle se met à jour automatiquement dans le template)
// api : pour exposer une propriété aux parents du composant (exemple : passer recordId depuis une page record)

import findCasesBySubject from '@salesforce/apex/AccountCasesController.findCasesBySubject'; 
// Importation de la méthode Apex pour pouvoir l'appeler depuis le composant LWC

// Déclaration d'une constante contenant les colonnes de la datatable
const COLUMNS = [
    { label: 'Sujet', fieldName: 'Subject', type: 'text' }, // Colonne pour afficher le "Subject" du Case
    { label: 'Statut', fieldName: 'Status', type: 'text' }, // Colonne pour afficher le "Status" du Case
    { label: 'Priorité', fieldName: 'Priority', type: 'text' }, // Colonne pour afficher la "Priorité" du Case
];

export default class AccountCaseSearchComponent extends LightningElement {
    // Déclaration de la classe du composant LWC, qui hérite de LightningElement

    @api recordId; 
    // Propriété publique pour récupérer l'ID du compte (Account) sur la page où est placé le composant

    @track cases;
    // Propriété réactive pour stocker les résultats (liste des cases récupérés)

    @track error;
    // Propriété réactive pour gérer et afficher une éventuelle erreur

    searchTerm = '';
    // Variable pour stocker le texte que l'utilisateur va saisir dans l'input (filtre par sujet)

    columns = COLUMNS;
    // Affectation de la constante COLUMNS à la propriété columns pour la datatable

    updateSearchTerm(event) {
        // Fonction déclenchée à chaque fois que l'utilisateur tape dans l'input
        this.searchTerm = event.target.value;
        // On récupère la valeur tapée par l'utilisateur et on la stocke dans searchTerm
    }

    handleSearch() {
        // Fonction déclenchée quand l'utilisateur clique sur le bouton "Rechercher"
        findCasesBySubject({ accountId: this.recordId, subjectSearchTerm: this.searchTerm })
            // Appel de la méthode Apex, on lui passe l'ID du compte + le terme de recherche
            .then(result => {
                // Si l'appel réussit (promesse résolue)
                this.cases = result; // On stocke les résultats dans cases (pour affichage)
                this.error = undefined; // On efface toute erreur précédente
            })
            .catch(error => {
                // Si une erreur survient lors de l'appel Apex
                this.error = 'Une erreur est survenue lors de la recherche des cases.'; // Message d'erreur
            });
    }
}
