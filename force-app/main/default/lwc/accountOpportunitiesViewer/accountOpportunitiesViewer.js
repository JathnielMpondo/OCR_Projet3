import { LightningElement, api, wire, track } from 'lwc'; // Importation des modules nécessaires de LWC
// LightningElement : classe de base pour tous les composants LWC
// api : pour exposer une propriété aux parents du composant (exemple : passer recordId depuis une page record)
// wire : pour appeler des méthodes Apex de manière réactive
// track : pour rendre une variable réactive (elle se met à jour automatiquement dans le template)
import { refreshApex } from '@salesforce/apex'; // Importation de la méthode refreshApex pour rafraîchir les données d'un appel Apex
// Importation de la méthode Apex pour pouvoir l'appeler depuis le composant LWC
// getOpportunities : méthode Apex qui récupère les opportunités d'un compte
// @salesforce/apex : chemin d'accès à la méthode Apex
// AccountOpportunitiesController : nom de la classe Apex qui contient la méthode getOpportunities
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities'; // Importation de la méthode Apex pour récupérer les opportunités d'un compte
// Importation de la méthode Apex pour récupérer les opportunités d'un compte

const COLUMNS = [ // Déclaration des colonnes de la datatable 
    { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
    { label: 'Montant', fieldName: 'Amount', type: 'currency' },
    { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
    { label: 'Phase', fieldName: 'StageName', type: 'text' }
];

export default class AccountOpportunitiesViewer extends LightningElement { // Déclaration de la classe du composant LWC
    // Importation des modules nécessaires de LWC :
    // LightningElement : classe de base pour tous les composants LWC
    // api : pour exposer une propriété aux parents du composant (exemple : passer recordId depuis une page record)
    // wire : pour appeler des méthodes Apex de manière réactive
    // track : pour rendre une variable réactive (elle se met à jour automatiquement dans le template)
    // refreshApex : pour rafraîchir les données d'un appel Apex
    // Importation de la méthode Apex pour pouvoir l'appeler depuis le composant LWC
  
    @api recordId;
    @track opportunities;
    @track error;
    @track searchTerm = ''; 
    columns = COLUMNS;
    wiredOpportunitiesData; // Variable pour stocker la réponse de l'appel Apex 

    @wire(getOpportunities, { recordId: '$recordId' }) // Appel de la méthode Apex getOpportunities 
    wiredOpportunities(result) {
        this.wiredOpportunitiesData = result; // Stocke la réponse pour le rafraîchissement
        const { data, error } = result;

        if (data) {
            this.opportunities = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
        }
    }

    updateSearchTerm(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        getOpportunities({ accountId: this.recordId })
            .then(result => {
                if (this.searchTerm) {
                    this.opportunities = result.filter(opp =>
                        opp.Name.toLowerCase().includes(this.searchTerm.toLowerCase())
                    );
                } else {
                    this.opportunities = result;
                }
                this.error = undefined; // On efface toute erreur précédente si la recherche réussit 
            })
            .catch(error => {
                this.error = 'Une erreur est survenue lors de la recherche des opportunités.';
                this.opportunities = undefined;
            });
    }

    handleRafraichir() {
        refreshApex(this.wiredOpportunitiesData); // Rafraîchit les données en appelant Apex à nouveau
    }
}
