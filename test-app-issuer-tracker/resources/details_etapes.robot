*** Settings ***

Documentation     == Keywords spécifiques à l'application My ==

*** Keywords ***

Il crée l'application ${nom de l'application} sur l'environnement ${nom de l'environnement} pour le client ${nom du client}

    Il retourne sur la page d'acceuil


    Il clique sur le bouton Créer dans la section "Applications"

    Il saisit les données suivantes :
    -  Nom              ${nom de l'application}
    -  Environnement    ${nom de l'environnement}
    -  Organization     ${nom du client}

    Il clique sur le bouton "Créer" dans le formulaire de création


Il ajoute les participants suivants à l'application :
    Set suite variable   ${action to reapeat}  Il ajoute le participant suivant à l'application

Il ajoute le participant suivant à l'application
    [Arguments]  ${prenom}  ${nom}  ${role}
    Form Add Existing Participant  ${role}  ${prenom}


Il retourne sur la page d'acceuil
        Form Go Homepage