# Requirements de l'application Bug Tracker

Ce ficher decrit des requirements fictifs pour l'application issue tracker.


## Profil client

Les requirements suivants concenrnent les clients iWE qui utilisent issue tracker

### REQ_01 - Déclaration d'une anomalie

Le client doit pouvoir soumettre une nouvelle anomalie sur les application auquel il est affecté

### REQ_01.2 - Ajout de document

Lors de la déclaration ou plus tard, le client peut joindre des documents à l'anomalie.

### REQ_02 -  Notifications email

Le client doit être informé par email en cas de changement d’état d’une anomalie.

### REQ_03 - Accès aux anomalies par le client

Le client doit avoir accès à tout instant au stock d’anomalies ouvertes.

### REQ_04 - Cloisonnement des données

Le client A ne doit en aucun cas avoir accès aux données (anomalies, fiches contacts, etc.) du client B.

### REQ_10 - Evolution du statut d'une anomalie par le client

Le client peut modifier le statut d'une anomalie

### REQ_10.1 - Validation d'un correctif
Le client peut valider un correctif

### REQ_10.2 - Rejet d'un correctif

Le client peut rejeter un correctif

## Requirements profil iWE

Les requirements suivants concenrnent les utilisateurs iWE qui utilisent issue tracker.

### REQ_05 - Notifications du chef de projet iWE

#### REQ_05.1 - Notification suite à une déclaration d'anomalie

Le chef de projet d’une application iWE doit être informé par une notification iWE dans le cas de création d’une nouvelle anomalie par son client.

#### REQ_05.2 - Notification en cas de changement de statut

Le chef de projet doit être informé par email en cas de changement d’état d’une anomalie.

### REQ_07 - Accès aux anomalies par le responsable d'application iWE

Le chef de projet d’une application iWE doit avoir accès à tout instant au stock d’anomalies ouvertes.

### REQ_08 - Droits de modification d'une anomalie par l'équipe projet iWE

Tout membre de l’équipe iWE doit pouvoir qualifier une anomalie et faire évoluer son statut.

### REQ_09 Champs internes à iWE

Les utilisateurs iWE ont accès à des champs de saisie internes non visibles par le client.
Ces champs sont utilisé pour la resolution de l'anomalie (analyse interne, chiffrage, solution apportée, tests...)
