import { LightningElement, api, wire, track } from 'lwc'; // Importer les éléments Lightning Web Components
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities'; // Importer la méthode Apex

export default class AccountOpportunitiesViewer extends LightningElement { // Déclarer la classe du composant Lightning Web Component
    @api recordId; // Déclarer une propriété @api pour récupérer l’ID de l’enregistrement de compte
    @track opportunities; // Déclarer une propriété @track pour stocker les opportunités à afficher
    @track error; // Initialisé à undefined

    columns = [ // Définir les colonnes de la table des opportunités à afficher dans le composant Lightning-datatable
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' }, // Chaque colonne est un objet avec un label, un fieldName et un type
        { label: 'Montant', fieldName: 'Amount', type: 'currency' }, // Le fieldName correspond au nom du champ de l’objet Opportunity
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' }, // Le type définit le type de données à afficher
        { label: 'Phase', fieldName: 'StageName', type: 'text' } // Le type 'currency' affiche la valeur comme une devise
    ];

    @wire(getOpportunities, { recordId: '$recordId' }) // Appeler la méthode Apex avec les paramètres
    wiredOpportunities({ error, data }) { // Traiter le résultat de la méthode Apex
        if (data) { // Si des données sont retournées
            this.opportunities = data; // Mettre à jour la propriété opportunities avec les opportunités retournées
            this.error = undefined; // Initialiser la propriété error à undefined
        } else if (error) { // Si une erreur est retournée
            this.error = this.getErrorMessage(error); // Mettre à jour la propriété error avec le message d’erreur
            this.opportunities = undefined; // Initialiser la propriété opportunities à undefined
        }
    }

    getErrorMessage(error) { // Déclarer une méthode pour obtenir le message d’erreur
        if (Array.isArray(error.body)) { // Si l’erreur est un tableau d’erreurs avec des messages d’erreur individuels 
            return error.body.map(e => e.message).join(', '); // Retourner les messages d’erreur séparés par une virgule
        } else if (typeof error.body.message === 'string') { // Si l’erreur est un objet avec un message d’erreur
            return error.body.message; // Retourner le message d’erreur 
        }
        return 'Une erreur est survenue.'; // Retourner un message d’erreur par défaut si aucun message n’est trouvé 
    }
}