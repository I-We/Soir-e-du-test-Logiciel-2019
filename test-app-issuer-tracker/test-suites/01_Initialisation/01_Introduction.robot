*** Settings ***

Documentation
...  SUITE DE TESTS BUGTRACKER
...  .........................
...
...  L'application My est un bug tracker mis à disposition des clients d'iWE pour y remonter toutes les anomalies relevées sur une release ainsi que les demandes d'évolution
...  complémentaires à une release en cours.
...
...  Pour plus de facilité, toute demande client est nommée Anomalie même si elle regroupe anomalies et demandes d'évolution.
...
...  Une anomalie suit un cycle de vie défini de son ouverture à sa clôture. Ce cycle de vie est traduit par des statuts tels que En cours d'analyse, Corrigée à valider, Correction validée, etc.
...  Les anomalies sont suivies par le client et le responsable d'application iWE via un board dédié appelé Stock d'anomalies.
...
...  .. contents:: Table des matières
...  \ \ \ \ \ :depth: 1
...


*** Variables ***


*** Test Cases ***

