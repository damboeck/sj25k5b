# Docker

## Allgemeines

## Dockerfile
  >docker build -t zielcontainername .

#### Container starten 
  >docker run -itd --name containername -p 2022:22 zielcontainername
  > 

## Im Unterricht verwendete Kommandos
<pre>
docker build -t ubuntu-ssh .
docker run -itd --name u5bssh -p 2022:22 ubuntu-ssh
docker kill u5bssh
docker rm u5bssh
docker run -itd --name u5bssh -p 2022:22 -v C:\github\Unterricht-HTL-DAMB\s25k5b\docker\ubuntu-ssh\data:/data ubuntu-ssh
</pre>

## Hausaufgaben
* Erstelle einen Docker-Container mit einem Apache-Webserver basierend auf Ubuntu:24.04
* Der Webserver soll eine statische HTML-Seite ausliefern die in einem lokalen Verzeichnis liegt
* Der Container soll im Hintergrund laufen und der Port 8080 des Hostsystems soll auf den Port 80 des Containers gemappt werden
* Erstelle ein Dockerfile und die notwendigen Dateien
* Baue den Container und starte ihn
* Teste die Erreichbarkeit der HTML-Seite über den Browser
