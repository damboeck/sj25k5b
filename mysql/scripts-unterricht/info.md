# Docker-Konfiguration für MySQL-Server und phpMyAdmin von ChatGPT erstellt.
````
Erstelle mir eine docker-compose.yml mit .env-Datei und wenn notwendig auch den notwendigen Dockerfile 
um folgende Serverkonfiguration zu realisieren. Packe alle Dateien in eine zip-Datei für einfachere Installation. 
Die Installation wird auf einem Windows-PC mir Docker-Desktop erfolgen.
Es soll ein MySQL-Server realisiert werden welcher die Datenbank in einem eigenen Volume hat. 
Daneben soll ein PhpMyadmin-Container für die Konfiguration der Datenbank laufen. 
Beide Container sollen über ein internes Docker-Netzwerk "dbnw" kommunizieren welches bei Bedarf 
automatisch angelegt werden soll. Die Ports von MySQL-Server und PhpMyadmin sowie das Root-Passwort 
der Datenbank sollen über .env Variable konfiguriert werden können. 
Weiters sollen MySQL-Server und phpMyadmin über die konfigurierten Ports vom Host und über das Netzwerk 
von jedem Rechner erreichbar sein.
````

# Ports:
* MySQL: 33306
* phpMyAdmin: 8913

# Passwörter:
* MySQL Root-Passwort: htl12!
* Benutzer htl: htl

