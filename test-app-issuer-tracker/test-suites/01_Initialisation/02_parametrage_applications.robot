*** Settings ***

Documentation
...
...  Paramétrage des applications
...  ============================
...
...  Les anomalies gérées dans le bug tracker sont relatives à une application client iWE en particulier.
...
...  Il est donc indispensable, pour pouvoir déclarer une anomalie, de paramétrer le bug tracker en indiquant la liste des applications sur lesquelles une anomalie peut être déclarée et le cas échéant, inviter les utilisateurs de l'organisation cliente
...  sur le bugtracker.
...
...  Le paramètrage des applications est effectué par un administrateur iWE.
...
...  Objectifs
...  ---------
...
...  Les objectifs des tests de paramétrage des applications sont :
...
...  -  Créer, en tant qu'administrateur, une nouvelle application et y ajouter un responsable d'application et un utilisateur client
...  -  Inviter un responsable client à l'application
...  -  Vérifier qu'un client n'a accès en lecture qu'à ses application (celles où il est participant).
...  -  Vérifier qu'un client n'a pas en création, modification, suppression aux application, y compris les siennes.
...
...  Pré-conditions
...  --------------
...
...  - 2 sociétés clientes sont enregistrée dans My (BUNNY et WARNER).
...
...  Scénario
...  --------

Suite Setup         Setup
Suite Teardown      Clean After Test
Force Tags          MY  specification

Resource            ../../resources/common.robot
Resource            ../../resources/details_etapes.robot

*** Variables ***

${FILE_PATH}             ${CURDIR}/../../../resources/fichiers/
${supprimer dossier}     True

*** Test Cases ***

Création de l'application LAPP1 par un administrateur
    [Tags]  specification

    L'administrateur se connecte à l'application MY

    Il crée l'application LAPP1 sur l'environnement Production pour le client BUNNY

Ajout des participants de l'application LAPP1     # Devrait disparaître avec le partage par organisation
    [Tags]  specification

    Il ajoute les participants suivants à l'application :
    -  Jean-Mi  Respapp      Chef de projet IWE
    -  Elmer  Resplapp1      Responsable client

    #Il invite Elmer via sa fiche contact et Elmer accepte l'invitation

Création de l'application LAPP2 par un administrateur
    [Tags]  specification

    Il crée l'application LAPP2 sur l'environnement Production pour le client WARNER

Ajout des participants de l'application LAPP2     # Devrait disparaître avec le partage par organisation
    [Tags]  specification

    Il ajoute les participants suivants à l'application :
    -  Jean-Mi  Respapp      Chef de projet IWE
    -  Daffy  Resplapp2      Responsable client
    -  Seb  Intégrateur      Chef de projet IWE

    #Il invite Daffy via sa fiche contact et Daffy accepte l'invitation

Vérification des droits sur les applications par le client
    [Tags]  REQ_04  specification

    Le client Elmer se connecte à l'application MY

    Il peut créer une anomalie sur LAPP2

    Il ne peut pas créer une anomalie sur LAPP1

    Les recherches suivantes ne retournent aucun résultat :
    -  Application  LAPP1
    -  Application  LAPP2
    -  Société      BUNNY
    -  Société      WARNER
    -  Individu     Elmer Resplapp1
    -  Individu     Daffy Resplapp2
    -  Individu     Jean-Mi Respapp

*** Keywords ***

Setup
    No operation

Clean After Test
    Close All Browsers