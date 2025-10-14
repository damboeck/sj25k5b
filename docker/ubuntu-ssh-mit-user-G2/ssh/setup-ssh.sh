#!/bin/bash
set -e

# Environment variables (falls nicht gesetzt, Standardwerte)
USER="${USER:-developer}"
USER_PASSWORD="${USER_PASSWORD:-changeme}"
ROOT_PASSWORD="${ROOT_PASSWORD:-}"

# 1) Erzeuge SSH-Hostkeys falls nötig
ssh-keygen -A || true

# 2) User anlegen (falls nicht vorhanden) und Home/SSH-Verzeichnis vorbereiten
if ! id -u "$USER" >/dev/null 2>&1; then
  useradd -m -s /bin/bash "$USER"
fi
mkdir -p /home/"$USER"/.ssh
chown -R "$USER":"$USER" /home/"$USER"
chmod 700 /home/"$USER"/.ssh || true

# 3) Passwörter setzen
echo "${USER}:${USER_PASSWORD}" | chpasswd
if [ -n "$ROOT_PASSWORD" ]; then
  echo "root:${ROOT_PASSWORD}" | chpasswd
  # Root-Login erlauben, wenn Passwort gesetzt ist
  sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config || true
  sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config || true
else
  sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config || true
  sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config || true
fi

# 4) PasswordAuthentication sicherstellen
if grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
  sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
else
  echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
fi

# 5) AuthorizedKeysFile sicherstellen
if ! grep -q "^AuthorizedKeysFile" /etc/ssh/sshd_config; then
  echo "AuthorizedKeysFile %h/.ssh/authorized_keys" >> /etc/ssh/sshd_config
fi

# 6) Start SSH daemon im Vordergrund
mkdir -p /var/run/sshd
exec /usr/sbin/sshd -D
