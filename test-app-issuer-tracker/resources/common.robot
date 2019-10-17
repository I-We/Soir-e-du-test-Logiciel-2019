*** Settings ***
Documentation     Common Import / Variable
Library           DateTime
Library           String
Library           Collections

Resource          ${RESOURCES_DIR}/app-french.robot

*** Variables ***

${DIALOGS_LIB}                              Dialogs
${URL BASE}    ${IWE DOMAIN}
${ROOT URL}    ${PROTOCOL}://${CUSTOMER DOMAIN}.${IWE DOMAIN}

${UTILISATEUR responsable jean-mi}      user.test+jm.responsable@iwecloud.com
${MOT DE PASSE responsable jean-mi}     user.test+jm.responsable@iwecloud.com
${MAIL responsable jean-mi}             user.test+jm.responsable@iwecloud.com

${UTILISATEUR intégrateur seb}          user.test+seb.integrateur@iwecloud.com
${MOT DE PASSE intégrateur seb}         user.test+seb.integrateur@iwecloud.com
${MAIL intégrateur seb}                 user.test+seb.integrateur@iwecloud.com

${UTILISATEUR administrateur}           user.test+chris.admin@iwecloud.com
${MOT DE PASSE administrateur}          user.test+chris.admin@iwecloud.com
${MAIL administrateur}                  user.test+chris.admin@iwecloud.com


${UTILISATEUR client elmer}             user.test+elmer.client@iwecloud.com
${MOT DE PASSE client elmer}            user.test+elmer.client@iwecloud.com
${MAIL client elmer}                    user.test+elmer.client@iwecloud.com


${UTILISATEUR client daffy}             user.test+daffy.client@iwecloud.com
${MOT DE PASSE client daffy}            user.test+daffy.client@iwecloud.com
${MAIL client daffy}                    user.test+daffy.client@iwecloud.com


&{USER MAP}     responsable jean-mi=responsable jean-mi
...             client elmer=client elmer
...             intégrateur seb=intégrateur seb
...             administrateur=administrateur
#
#&{ROLE MAP}
#...    cabinet d'expertise d'assuré=Cabinet d'expertise d'Assuré
#...    interlocuteur de l'assuré=Interlocuteur assuré

${SEARCH SELECT LABEL}   Sélectionner
*** Keywords ***
