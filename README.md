# Workshop iWE - Soirée du test logiciel

## GUIDELINE - START

### 1. Ouvrez le projet app-issue-tracker sur Visual Studio Code

Clic droit sur le répertoire app-issue-tracker > Ouvrir dans un terminal
Dans le terminal, saisissez "code ." > Le projet s'ouvre alors dans Visual Studio Code

### 2. Installer les extensions

Dans le panneau gauche afficher le panneau des extensions (ou raccourci clavier Ctrl+Shift+X)
Recherchez les extensions suivantes et les installer
- robot framework language
- Robot Framework Intellisense

### 3. Visualiser la documentation des keywords

Depuis un terminal QUE VOUS NE FERMEREZ PAS, lancez les commandes

    python -m rfhub ~/workshop/functionnal-tests/resources/app-french

Suivez le lien http://127.0.0.1:7070, cela vous servira pour les exercices d'écriture de scénarios ensuite

### 4. Observez le scénario de test déjà écrit sur l'application iWE Bug Tracker (MY), l'exécuter et observez les fichiers de logs

Dans visual Studio code : Ouvrir le fichier "tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot" et observez la syntaxe, le contenu du test

Dans le terminal (déjà ouvert ou celui intégré à VSCode [Terminal > New Terminal]): Lancer la commande avec l'option BROWSER_DISPLAY_MODE pour observer l'exécution du test

    robot -A tests/config/demo2 -v BROWSER_DISPLAY_MODE: tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

Ouvrir le fichier de log présent à l'emplacement indiqué dans le terminal soit via l'explorateur de documents soit avec la commande

    firefox /home/demo2/workshop/app-issue-tracker/output/log.html

## GUIDELINE - Réaliser des actions manuelles dans l'application

**Lien de l'application MY**

    https://workshop-stl.staging.i-we.io

**Login/Mot de passe pour se connecter avec les différents profils client, chef de projet, intégrateur**

    code workshop/app-issue-tracker/tests/resources/common.robot

## EXERCICES

## 5. Réaliser l'exercice 1

### 5.1 Ajouter une exigence au référentiel des exigences

Dans Visual Studio Code, ouvrir le fichier des exigences

    tests/requirements/requirements.md

Ajouter dans ce fichier, avec la même syntaxe que les autres exigences, le nouveau besoin exprimé par le client.

    Exemple :

    ### REQ_20 - Accès aux anomalies abandonnées

    Le client souhaite avoir accès à la liste des anomalies abandonnées


### 5.2 Lancer l'outil de vérification de la couverture de tests

Dans un terminal, lancer la commande

    npm run gen-test-compliance

Ouvrez le fichier de couverture généré et y observez que l'exigence ajoutée n'est pas encore couverte

    firefox test-compliance.html


### 5.3 Ecrire le test pour couvrir l'exigence

Dans visual Studio code : Ouvrir le fichier prévu pour rédiger la spécification de la demande

    tests/test-suites/02_Gestion_d_une_anomalie/02_Scenario_anomalie_annulee.robot

Rédiger le test à l'aide des keywords disponibles dans le scénario existant et à l'adresse http://127.0.0.1:7070

    - 1e testcase : le client déclare une anomalie (indice : identique au 1e testcase déjà présent dans le test observé précédemment)
    - 2e testcase : le client annule l'anomalie déclarée (indice : pour cela trouver un keyword qui permet de modifier une donnée)
    - 3e testcase : le client ouvre depuis sa page d'accueil, un nouveau rapport listant les anomalies abandonnées (indice : chercher dans les keywords http://127.0.0.1:7070 un keyword permettant d'ouvrir un rapport)

Ajouter le tag avec le nom de l'exigence dans le 3e test


### 5.4 Constatez que la couverture de tests couvre désormais l'exigence

Dans un terminal, lancer la commande

    npm run gen-test-compliance

Ouvrez le fichier de couverture généré et y observez que l'exigence ajoutée n'est pas encore couverte

    firefox test-compliance.html


### 5.5 Lancer le test en mode DRY pour vérifier rapidement que les keywords utilisés existent et que la syntaxe est correcte

Dans le terminal lancer la commande

    robot --dry -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/02_Scenario_anomalie_annulee.robot
    En cas d'erreur observez les fichiers de logs  firefox /home/demo2/workshop/app-issue-tracker/output/log.html


### 5.6 Si le mode dry ne remonte aucune erreur, exécutez le test et observez qu'il échoue

Soit en mode normal (avec visualisation des actions):

    robot -A tests/config/demo2 -v BROWSER_DISPLAY_MODE: tests/test-suites/02_Gestion_d_une_anomalie/02_Scenario_anomalie_annulee.robot

Soit en mode headless (sans visualisation des actions):

    robot -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/02_Scenario_anomalie_annulee.robot

NORMALEMENT A CETTE ETAPE LE TEST ECHOUE CAR LA FONCTIONNALITE N'EST PAS ENCORE DEVELOPEE


### 5.7 NOUS DEPLOYONS LA NOUVELLE VERSION DE L'APPLICATION


### 5.8 Exécuter le test et observez qu'il fonctionne (même commande que précédemment)


### 5.9 Générer la documentation et observer que le test ajouté est présent

Dans un terminal, lancer la commande

    npm run gen-test-specifications

Ouvrir le fichier généré

    firefox test-specifications.html


## 6. Réaliser l'exercice 2

- Modifier le test pour couvrir l'exigence client REQ_10.2 - Rejet d'un correctif

- Exécuter le test (voir les commandes déjà utilisées pour l'exercice 1)

- Générer la documentation et observer que le test ajouté est présent (voir les commandes déjà utilisées pour l'exercice 1)

- Générer la couverture de test et observer que l'exigence est désormais couverte (voir les commandes déjà utilisées pour l'exercice 1)



## RECAPITULATIF DES COMMANDES

### Commandes pour lancer le test

> robot -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

Avec Option pour visualiser

> robot -A tests/config/demo2 -v BROWSER_DISPLAY_MODE: tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

Pour lancer le tests sans execution mais pour contrôler que votre test est bien écrit

> robot --dry -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

### Générer les spécifications

> npm run gen-test-specifications

### Générer la couverture de test

> npm run gen-test-compliance

Ouvrir le fichier généré :

## Documentation

### Keywords publiques (documentation officiel)

Builtin : https://robotframework.org/robotframework/latest/libraries/BuiltIn.html
(Keywords génériques de robotframework)

Selenium : http://robotframework.org/Selenium2Library/Selenium2Library.html
(Keywords liés aux actions UI)


