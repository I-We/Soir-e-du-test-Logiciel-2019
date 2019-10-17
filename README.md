# Soir-e-du-test-Logiciel-2019
Material for Soirée du test Logiciel 2019 event


### GUIDE LINE

- Installer les extensions

- Ouvrir le fichier pour voir le code existant (tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot)
- Lancer la commande avec l'option BROWSER_DISPLAY_MODE pour comprendre ce qui se passe
- Analyse des logs
- Essayer de repérer l'endroit concerné par la modification demandé à l'exercice
- S'aider de ce qui existe et des keywords disponible pour résoudre l'exercice
- Lancer en mode --dry pour vérifier qu'on a pas fait d'erreur
- Si OK -> Lancer en headless ou non pour vérifier que la modification du test fonctionne
- Lancer la commande pour générer la spécification de test
- Lancer la commande pour générer la couverture de test

- Faire la même chose pour le deuxième exercice




### Extenstions à installer

- robot framework language
- Robot Framework Intellisense


#### EXECUTION TESTS

# Commande pour lancer le test

robot -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

# Avec Option pour visualiser

robot -A tests/config/demo2 -v BROWSER_DISPLAY_MODE: tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot

# Pour lancer le tests sans execution mais pour contrôler que votre test est bien écrit

robot --dry -A tests/config/demo2 tests/test-suites/02_Gestion_d_une_anomalie/01_Scenario_anomalie_corrigee.robot






#### GENERATION DOCUMENTATION

# Générer la spécification

npm run gen-test-specifications


# Générer la couverture

gen-test-compliance






#### KEYWORDS


# Keywords privés
La majorité des keywords se trouve directement dans le fichier de test (en bas, section *** Keywords ***)

Si besoin, des keywords supplémentaires sont disponibles dans le dossier :
node_modules/functionnal-tests/resources/app-french/wishlist/


# Keywords publiques

Builtin : https://robotframework.org/robotframework/latest/libraries/BuiltIn.html
(Keywords génériques de robotframewor)

Selenium : http://robotframework.org/Selenium2Library/Selenium2Library.html
(Keywords liés aux actions UI)
