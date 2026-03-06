pia-pdfgen
================

Team Pia sin pdf-generator for dokumenter produsert av fagsystemet Fia.

# Komme i gang

## Sandboxing Handlebars 
For å teste ut maler og data kan du bruke [handlebarsjs sandbox](https://handlebarsjs.com/playground.html)

Lim inn maler fra `/templates/pia/` i "Template" og data fra `/data/pia/` i "Input" for å se hvordan det ser ut.

Den forslått koden i ``Preparation-Script`` boks på denne siden kan du kommentere ut. 

"Output" vil vise deg resultatet av template med data.

## Teste lokalt

Kjør `./run.sh` i rot mappa. Dette burde starte opp et docker image som burde svare på feks:

`http://localhost:8080/api/v1/genpdf/pia/behovsvurdering`

`http://localhost:8080/api/v1/genpdf/pia/samarbeidsplan`

hvor `ia-samarbeid`|`behovsvurdering` er en template (`/templates/pia/<template>`) med data fra `/data/pia/<template>.json`
 
## Lage en release

Ved push til main blir det laget en release draft i Github. Dersom man vil opprette en release for å (feks) 
benytte i tester lokalt går man inn på [Releases](https://github.com/navikt/pia-pdfgen/releases), der bør det ligge
en draft-release som man kan gå inn på for å publisere.

---

# Henvendelser

Spørsmål knyttet til koden eller prosjektet kan stilles som issues her på GitHub

## For NAV-ansatte

Interne henvendelser kan sendes via Slack i kanalen #team-pia-utvikling.
