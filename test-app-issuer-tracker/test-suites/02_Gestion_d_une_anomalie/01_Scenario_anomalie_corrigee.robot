*** Settings ***

Documentation
...
...  Gestion d'une anomalie
...  ======================
...
...  Un client peut déclarer une anomalie depuis la homepage de le bug tracker MY.
...
...  Cette anomalie est ensuite qualifiée par iWE et suit un workflow traduit par différents statuts.
...
...  Tous les clients d'iWE dispose d'une vue dédiée à leurs Anomalies. Ainsi le client d'une application ne peut en aucun cas accéder aux anomalies d'une application d'un autre client.
...  Un même utilisateur appartenant à une organisation cliente peut gérer plusieurs applications simultanément et ainsi avoir une vue sur ces différentes applications.
...
...  Les utilisateurs faisant partie de la société iWE ont accès à toutes les anomalies quelle que soit l'application.
...
...  Le workflow d'une anomalie est le suivant :
...
...  .. image:: ./tests/resources/workflow.png
...
...  Objectifs
...  ---------
...
...  Les objectifs des tests de gestion d'une anomalie sont :
...
...  -  Déclarer, par un client ou par un membre d'iWE une anomalie, y associer des documents
...  -  Valider le workflow d'une anomalie qui est clôturée après une correction ou rejetée
...  -  Vérifier que les notifications sont bien déclenchée à chaque changement dans le cycle de vie d'une anomalie
...  -  Vérifier que les rapports de la homepage permettent de retrouver l'anomalie à chaque étape clé de son avancement
...  -  Vérifier la visibilité d'une anomalie (cloisonnement des données par organisation sécurisée)
...
...  Pré-conditions
...  --------------
...
...  - 1 client gérant 2 applications
...  - 1 autre client gérant une autre application
...  - 2 responsables applicatif dont 1 gérant 2 applications, l'autre gérant la 3e application.
...
...  Scénario - Anomalie corrigée
...  ----------------------------
...

Suite Setup         Setup
Suite Teardown      Clean After Test
Force Tags          issue-tracker    sanity

Resource            ../../resources/common.robot
Resource            ../../resources/details_etapes.robot

*** Variables ***

${FILE_PATH}             ${CURDIR}/../../resources/data/
${supprimer dossier}     True

*** Test Cases ***

Déclaration d'une nouvelle anomalie par le client
    [Tags]  REQ_01  REQ_01.2  REQ_04  REQ_09

    Le client Elmer se connecte à l'application MY

    Il démarre le formulaire de déclaration d'une anomalie

    # Vérifier qu'il ne peut pas sélectionner "LAPP2 Production" dans le champ "Application" du formulaire

    Il saisit les données suivantes dans le formulaire :
    -  Titre                            L'envoi d'email ne fonctionne plus
    -  Description                      Depuis la fiche contact d'une société, je ne parviens plus à accéder à la fonctionnalité d'envoi d'email
    -  Référence du dossier             2019XX00002
    -  Lien du dossier                  https://starter-ft.staging.i-we.io/#/5644ba6a3f38b81700bbdfc6/case/starter-Organization/5cd41807a3ea234600c133c1
    -  Application                      LAPP1 Production
    -  Version de l'application         1.0
    -  Criticité                        Majeur
    -  Type                             Anomalie

    Il accède à l'étape Documents

    Il dépose les documents suivants dans le formulaire     exemple_bug_tracker.png

    Il termine le formulaire de déclaration

    Résultats attendus :
        La référence de l'Anomalie est générée
        Le statut de l'anomalie est Nouveau
        Les champs suivants sont masqués :
        -  Plateforme ?
        -  Estimation (jours)
        -  Temps passé (jours)
        -  Date de livraison (prévisionnelle)
        -  Version de l'application (prévisionnelle)
        -  Description pour iWE
        -  Fichier des spécifications
        -  Commentaire durant le point projet
        La date d'avancement Nouvelle anomalie déclarée est égale à ${date du jour}
        Le jalon Date de creation est atteint
        Le jalon Nouvelle anomalie déclarée est atteint

Le client ne peut pas changer le statut de l'anomalie, il peut uniquement l'annuler

        Le statut ne peut prendre que les valeurs Nouveau et Annulée

Vérification des rapports et des notifications du chef de projet iWE
    [Tags]  REQ_05  REQ_05.1

    Le responsable Jean-Mi reçoit une notification iWE "Nouvelle anomalie déclarée" qui lui permet d'accéder à l'anomalie.

    L'anomalie est également accessible via le rapport "Les nouvelles anomalies".

Demande d'informations supplémentaires par le responsable de l'application
    [Tags]  REQ_02

    Le responsable Jean-Mi ouvre l'anomalie à partir du rapport "Les nouvelles anomalies", consulte le document "exemple_bug_tracker.png" et envoie un message de "Demande de précisions" à Elmer Resplapp1

    Il passe ensuite le statut de l'anomalie à "Informations supplémentaires à fournir"

    Résultats attendus :
        Le client Elmer est notifié par email du changement de statut de l'anomalie

Compléments apportés par le client
    [Tags]

    Le client Elmer se connecte à l'application MY

    Il ouvre l'anomalie à partir du rapport   Informations à fournir

    Il répond au message "Demande de précisions" et repasse le statut de l'anomalie à "En cours d'analyse"

    Résultats attendus :
        L'anomalie n'apparaît plus dans le rapport "Informations à fournir"

Analyse de l'anomalie par iWE et ajout de détails dans les champs internes
    [Tags]  REQ_09

    Le responsable Jean-Mi ouvre le message "RE: Demande de précisions" depuis le rapport de ses messages non traités et le passe à traité

    Il saisit, dans la section "Information sur l'anomalie" de la page "Détails", les données suivantes :
    -  Description pour iWE                 Anomalie à prendre en compte rapidement, plus urgente que l'autre client
    -  Fichier des spécifications           http://google.com
    -  Commentaire durant le point projet   Le client insiste très lourdement
    Il clique sur le bouton "Mettre à jour" de la section Information sur l'anomalie   # <<< C'EST VRAIMENT TROP MOCHE

Planification de la correction par iWE
    [Tags]  REQ_02  REQ_09

    Durant la réunion projet avec le client, il planifie la correction pour la version 2 de l'application

    Le client Elmer accède à l'anomalie depuis la notification sur iWE de la planification de la correction de l'anomalie

    Résultats attendus :
        La donnée Version de l'application (prévisionnelle) est visible mais non modifiable pour le client dans la section Information sur l'anomalie de la page Détails
        Les données suivantes ne sont pas visibles du client :
        -  Fichier des spécifications
        -  Commentaire durant le point projet

Correction et livraison du correctif pour validation client
    [Tags]  REQ_02  REQ_08

    L'intégrateur seb développe le correctif et en informe son responsable

    Le responsable Jean-Mi informe ensuite le client que le correctif a été livré

    Résultats attendus :
        Le client Elmer est notifié sur iWE de la correction de l'anomalie

Validation par le client du correctif livré
    [Tags]  REQ_10  REQ_10.1

    Le client Elmer se connecte à l'application MY

    Il ouvre l'anomalie à partir du rapport  Corrections à valider

    Il passe ensuite le statut de l'anomalie à "Correction de l’anomalie validée"

    Résultats attendus :
        L'anomalie n'apparaît plus dans le rapport "Corrections à valider"
        L'anomalie est également accessible via le rapport "Toutes les anomalies".

Clôture de l'anomalie
    [Tags]

    Le responsable Jean-Mi se connecte à l'application MY

    Il ouvre l'anomalie à partir du rapport  Les correctifs d'anomalie validées

    Il clôture l'anomalie

    Résultats attendus :
        L'anomalie n'apparaît plus dans le rapport "Les correctifs d'anomalie validées"











*** Keywords ***

######## ACTIONS ########

Le ${utilisateur} ouvre l'anomalie à partir du rapport "${nom du rapport}", consulte le document "${nom du document}" et envoie un message de "${sujet}" à ${destinataire du message}
    [Documentation]    Il ouvre le rapport indiqué depuis la Homepage puis ouvre l'anomalie concernée
    ...                Il consulte le document indiqué
    ...                Il envoi un message
    ${utilisateur} se connecte à l'application MY

    Il ouvre l'anomalie à partir du rapport  ${nom du rapport}

    Il consulte le document  ${nom du document}

    Il envoie un message "${sujet}" à ${destinataire du message}

Il ouvre l'anomalie à partir du rapport
    [Documentation]    Il ouvre le rapport indiqué depuis la Homepage puis ouvre l'anomalie concernée
    [Arguments]    ${nom du rapport}
    ${url dossier} =   Fetch From Right   ${url dossier}    .io
    Set Suite Variable  ${url dossier}
    Il ouvre le dossier à partir du rapport  ${nom du rapport}

Il passe ensuite le statut de l'anomalie à "${nouveau statut}"
    [Documentation]    Il change le statut de l'anomalie
    Il saisit, dans la section "Information sur l'anomalie" de la page "Détails", la donnée "Statut" avec la valeur "${nouveau statut}"

Il répond au message "${sujet}" et repasse le statut de l'anomalie à "${statut}"
    [Documentation]    Il accède à l'onglet Communications
    ...                Il ouvre la communication concernée
    ...                Il crée une réponse
    ...                Il envoi la réponse
    ...                Il change le statut de l'anomalies
    Il consulte la page Communications

    Open the communication   ${sujet}
    Create a reply to the message     Réponse à ${sujet}
    Send the Message

    Il passe ensuite le statut de l'anomalie à "${statut}"

${utilisateur} développe le correctif et en informe son responsable
    [Documentation]    L'utilisateur se connecte
    ...                Depuis n'importe où, il recherche l'anomalie depuis la barre de recherche et y accède
    ...                Il passe le statut de l'anomalie à "En cours de correction"
    ...                Il passe le statut de l'anomalie à "Développement terminé"
    ...                Il envoi un message à son responsable

    ${utilisateur} se connecte à l'application MY

    Il ouvre l'anomalie depuis la recherche globale     ${REF_DOSSIER_EN_COURS}

    Il passe ensuite le statut de l'anomalie à "En cours de correction"
    Il passe ensuite le statut de l'anomalie à "Développement terminé"

    Il envoie un message "Développement terminé" à Jean-Mi Respapp


${utilisateur} informe ensuite le client que le correctif a été livré
    [Documentation]    L'utilisateur se connecte
    ...                Depuis n'importe où, il recherche l'anomalie depuis la barre de recherche et y accède
    ...                Il passe le statut de l'anomalie à "En cours de correction"
    ${utilisateur} se connecte à l'application MY

    Il ouvre l'anomalie depuis la recherche globale    ${REF_DOSSIER_EN_COURS}

    Il passe ensuite le statut de l'anomalie à "Corrigée et à valider"

Il ouvre l'anomalie depuis la recherche globale
    [Documentation]    Depuis n'importe où, il recherche l'anomalie depuis la barre de recherche et y accède
    [Arguments]    ${recherche}
    Form Global Search  ${recherche}   open index=1

Il clôture l'anomalie
    [Documentation]    Il change le statut de l'anomalie à Résolue
    Il passe ensuite le statut de l'anomalie à "Résolue"


Le ${utilisateur} ouvre le message "${objet du message}" depuis le rapport de ses messages non traités et le passe à traité
    [Documentation]    L'utilisateur se connecte
    ...                Il ouvre le message à partir du rapport Mes messages non traités sur la homepage
    ...                Il marque le message comme traité
    ${utilisateur} se connecte à l'application MY

    Il ouvre le message ${objet du message} à partir du rapport Mes messages non traités

    Il marque le message comme traité

Durant la réunion projet avec le client, il planifie la correction pour la version ${numéro de version prévisionnelle} de l'application
    [Documentation]    Il saisit des données dans la section "Information sur l'anomalie" de la page "Détails"
    Il saisit, dans la section "Information sur l'anomalie" de la page "Détails", les données suivantes :
    -  Statut                                         À corriger
    -  Version de l'application (prévisionnelle)      ${numéro de version prévisionnelle}
    Il clique sur le bouton "Mettre à jour" de la section Information sur l'anomalie

######## VERIFICATIONS ########


Le responsable Jean-Mi reçoit une notification iWE "${nom jalon}" qui lui permet d'accéder à l'anomalie.
    [Documentation]     Le responsable se connecte
    ...                 Il ouvre la notification qu'il vient de recevoir et la vérifie
    Le responsable Jean-Mi se connecte à l'application MY
    Il ouvre la notification de jalon ${nom jalon} et vérifie son contenu


Vérifier qu'il ne peut pas sélectionner "${valeur}" dans le champ "${nom_donnee}" du formulaire
    [Documentation]     Il ne peux pas saisir de valeur dans le champs indiqué
    Run Keyword And Expect Error   	AssertionError     Il saisit ${nom_donnee} avec la valeur "${valeur}" dans le formulaire


Le client Elmer est notifié sur iWE ${objet de la notification}
    [Documentation]     Le client se connecte et vérifie qu'il a bien reçu une notification
    Le client Elmer se connecte à l'application MY

    Run Keyword If   "${objet de la notification}" == "de la planification de la correction de l'anomalie"     Il a reçu une notification "Correction de l'anomalie planifiée" lui permettant d'accéder à la fiche de l'anomalie
    ...    ELSE IF   "${objet de la notification}" == "de la correction de l'anomalie"                         Il a reçu une notification "Anomalie corrigée" lui permettant d'accéder à la fiche de l'anomalie

Le client Elmer accède à l'anomalie depuis la notification sur iWE ${objet de la notification}
    [Documentation]     Le client se connecte et accède à l'anomalie depuis la notification qu'il vient de recevoir
    ${first_number} =  Get Substring   ${date du jour}  start=0  end=1
    ${status} =   Run Keyword And Return Status   Should Be Equal   ${first_number}   0
    ${without_first} =   Get Substring   ${date du jour}   1
    Run Keyword If   ${status}    Set Test Variable   ${date_jalon}    ${without_first}
    ...    ELSE IF   not ${status}    Set Test Variable   ${date_jalon}    ${date du jour}
    Le client Elmer est notifié sur iWE ${objet de la notification}
    Open Notification
    Run Keyword If   "${objet de la notification}" == "de la planification de la correction de l'anomalie"     Navigate From Case Milestone Notification to Case       ${REF_DOSSIER_EN_COURS}     ${date_jalon}    text=Correction de l'anomalie planifiée le
    ...    ELSE IF   "${objet de la notification}" == "de la correction de l'anomalie"                         Navigate From Case Milestone Notification to Case       ${REF_DOSSIER_EN_COURS}     ${date_jalon}    text=Anomalie corrigée le

Il a reçu une notification "${nom jalon}" lui permettant d'accéder à la fiche de l'anomalie
    [Documentation]     Il a reçu une notification et accède à l'anomalie depuis celle-ci
    Il ouvre la notification de jalon ${nom jalon} et vérifie son contenu

Le client Elmer est notifié par email du changement de statut de l'anomalie
    [Documentation]     Le client reçoit une notification par email
    ${mailIndex}=  Check Email Has been received  user=${MAIL client elmer}   subject=[iWE][${Env Name}] Notification de jalon


La donnée ${nom de la donnée} est visible mais non modifiable pour le client dans la section ${nom de la section} de la page ${nom de la page}
    [Documentation]     Vérifie l'affichage d'une donnée
    ...                 Vérifie qu'on ne peux pas modifier cette donnée
    Il consulte la page Détails

    Le champ ${nom de la donnée} est affiché dans la section ${nom de la section}

    Le champ ${nom de la donnée} n'est pas affiché dans la section ${nom de la section} en mode édition


La date d'avancement ${nom_donnee} est égale à ${valeur}
    [Documentation]     Vérifie la valeur d'une date d'avancement
    Il consulte la page Avancement
    Le champ ${nom_donnee} a la valeur "${valeur}"

Le statut ne peut prendre que les valeurs Nouveau et Annulée
    [Documentation]     Vérifie les valeurs possible pour le champs "Statut"
    Il saisit, dans la section "Information sur l'anomalie" de la page "Détails", les données suivantes :
    -  Statut    Nouveau
    -  Statut    Annulée
    Il clique sur le bouton "Annuler" de la section Information sur l'anomalie


L'anomalie est également accessible via le rapport "${nom rapport}".
    [Documentation]     Vérifier que l'anomalie est présente dans le rapport indiqué
    ${url dossier} =   Fetch From Right   ${url dossier}    .io
    Set Suite Variable  ${url dossier}
    Form Go Homepage
    Il ouvre le rapport    ${nom rapport}
    Wait Until Keyword Succeeds    5   0.5s    Page Should Contain Element    xpath=//iwe-report-page//table/tbody//td[.//*[contains(@href,"${url dossier}")]]//span
    Form Go Homepage

L'anomalie n'apparaît plus dans le rapport "${nom_rapport}"
    [Documentation]     Vérifie que l'anomalie n'est pas présente dans le rapport indiqué
    Form Go Homepage
    Il ouvre le rapport  ${nom_rapport}
    Page Should Not Contain Element    xpath=//iwe-report-page//table/tbody//td[.//*[contains(@href,"${url dossier}")]]//span


Les données suivantes ne sont pas visibles du client :
    [Documentation]     Vérifie que des champs ne sont pas visible
    Les champs suivants sont masqués :


######## AUTRES ########

Setup
    [Documentation]     Définition du chemin pour les fichiers à charger
    ...                 Récupération de la date du jour et formatage pour n'avoir que la date
    ${FILE_PATH} =     Normalize Path   ${FILE_PATH}
    Set Suite Variable   ${FILE_PATH}

    ${DateAndTime} =  Get Current Date
    ${date du jour} =  Convert date   ${DateAndTime}    result_format=%d/%m/%Y
    Set Suite Variable     ${date du jour}

Clean After Test
    [Documentation]     Fermeture de toutes les fenêtres ouvertes
    Close All Browsers