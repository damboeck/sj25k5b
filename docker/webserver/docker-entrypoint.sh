#!/bin/bash
set -e

# ENV defaults
: "${CONTAINER_WEBROOT:=/var/www/html}"
: "${SSH_USER:=webuser}"
: "${SSH_PASSWORD:=changeme}"

# 1) Self-signed certificate (erstellt nur, wenn noch nicht vorhanden)
if [ ! -f /etc/ssl/certs/selfsigned.crt ] || [ ! -f /etc/ssl/private/selfsigned.key ]; then
  echo "Erzeuge self-signed TLS-Zertifikat..."
  mkdir -p /etc/ssl/private
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:4096 \
    -subj "/C=AT/ST=Vienna/L=Vienna/O=Local/CN=localhost" \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt
  chmod 600 /etc/ssl/private/selfsigned.key
fi

# 2) SSH: Benutzer anlegen / Passwort setzen (falls noch nicht vorhanden)
if ! id -u "${SSH_USER}" >/dev/null 2>&1; then
  echo "Lege SSH-Benutzer ${SSH_USER} an..."
  useradd -m -s /bin/bash "${SSH_USER}" || true
fi
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# SSH-Server config: Passwort-Login erlauben (für Container-Testsystem)
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config || true
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config || true

# 3) Falls Webroot leer ist, Beispielindex erzeugen
if [ -d "${CONTAINER_WEBROOT}" ]; then
  if [ -z "$(ls -A ${CONTAINER_WEBROOT})" ]; then
    echo "Webroot ist leer — lege Beispielseite an..."
    cat > ${CONTAINER_WEBROOT}/index.php <<'PHP'
<?php
echo "<h1>Apache + PHP läuft</h1>";
echo "<p>PHP-Version: " . phpversion() . "</p>";
PHP
    chown -R www-data:www-data ${CONTAINER_WEBROOT}
  fi
fi

# 4) Apache SSL Site aktivieren
a2ensite default-ssl.conf >/dev/null 2>&1 || true
a2enmod ssl >/dev/null 2>&1 || true

# Aufräumen / Start supervisord (CMD überschreibt supervisord args falls gesetzt)
exec "$@"
