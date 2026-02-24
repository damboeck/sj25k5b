# MySQL + phpMyAdmin (Docker Compose)

This package starts:
- **MySQL 8.0** (data persisted in a Docker volume)
- **phpMyAdmin** for DB administration

Both containers communicate via an internal Docker bridge network named **dbnw** (created automatically).

# Base configuration is created from ChatGPT
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

## Prerequisites (Windows)
- Docker Desktop installed and running.

## Quick start
1. Copy `.env.example` to `.env` and adjust values.
2. Start:
   ```powershell
   docker compose up -d
   ```
3. Open phpMyAdmin in the browser:
   - http://localhost:${PMA_PORT}  (default: http://localhost:8080)

## Connection details
### From the host (Windows)
- MySQL: `127.0.0.1:${MYSQL_PORT}` (default `127.0.0.1:3306`)
- User: `root`
- Password: value of `MYSQL_ROOT_PASSWORD`

### From another computer in your LAN
- MySQL: `<HOST-IP>:${MYSQL_PORT}`
- phpMyAdmin: `http://<HOST-IP>:${PMA_PORT}`

> Note: This requires Windows firewall / router to allow inbound connections to the chosen ports.

## Data persistence
MySQL stores data in the Docker volume **mysql_data**.  
Stopping/removing containers does **not** delete the volume unless you explicitly remove it:
```powershell
docker compose down -v
```

## Troubleshooting
- View logs:
  ```powershell
  docker compose logs -f
  ```
- If a port is already in use, change `MYSQL_PORT` and/or `PMA_PORT` in `.env`.
