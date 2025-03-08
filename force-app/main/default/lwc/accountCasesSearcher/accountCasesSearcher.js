import { LightningElement, track, api } from 'lwc'; // Importer les éléments Lightning Web Components
import findCasesBySubject from '@salesforce/apex/AccountCasesController.findCasesBySubject'; // Importer la méthode Apex

const COLUMNS = [ // Définir les colonnes de la table des cas à afficher dans le composant Lightning-datatable
    { label: 'Sujet', fieldName: 'Subject', type: 'text' }, // Chaque colonne est un objet avec un label, un fieldName et un type
    { label: 'Statut', fieldName: 'Status', type: 'text' }, // Le fieldName correspond au nom du champ de l’objet Case
    { label: 'Priorité', fieldName: 'Priority', type: 'text' }, // Le type définit le type de données à afficher
];

export default class AccountCaseSearchComponent extends LightningElement { // Déclarer la classe du composant Lightning Web Component
    @api recordId; // Déclarer une propriété @api pour récupérer l’ID de l’enregistrement de compte
    @track cases; // Déclarer une propriété @track pour stocker les cas à afficher
    @track error; // Déclarer une propriété @track pour stocker les erreurs
    @track isLoading = false; // Déclarer une propriété @track pour gérer l’affichage d’un indicateur de chargement
    searchTerm = ''; // Déclarer une propriété pour stocker le terme de recherche
    columns = COLUMNS; // Déclarer une propriété pour stocker les colonnes de la table

    updateSearchTerm(event) { // Déclarer une méthode pour mettre à jour le terme de recherche
        this.searchTerm = event.target.value; // Mettre à jour la propriété searchTerm avec la valeur saisie
    }

    handleSearch() { // Déclarer une méthode pour rechercher les cas en fonction du sujet
        this.isLoading = true; // Afficher un indicateur de chargement
        findCasesBySubject({ accountId: this.recordId, subjectSearchTerm: this.searchTerm }) // Appeler la méthode Apex avec les paramètres
            .then(result => { // Traiter le résultat de la méthode Apex
                this.cases = result; // Mettre à jour la propriété cases avec les cas retournés
            })
            .catch(error => { // Traiter les erreurs de la méthode Apex
                this.error = error.body ? error.body.message : 'Une erreur est survenue.'; // Mettre à jour la propriété error avec le message d’erreur
            })
            .finally(() => { // Exécuter du code après le traitement du résultat ou des erreurs
                this.isLoading = false; // Cacher l’indicateur
            });
    }
}