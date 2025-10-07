#!/bin/bash
set -euo pipefail

# Wenn keine Variablen gesetzt sind, werden Standardwerte verwendet (ggf. unsicher!)
: "${ROOT_PASSWORD:=root}"
: "${HTL_USER:=htl}"
: "${HTL_PASSWORD:=htl}"

echo "==> Generiere SSH-Host-Keys falls nicht vorhanden"
ssh-keygen -A >/dev/null 2>&1 || true

echo "==> SSHD Konfiguration anpassen (Root/Login/PasswordAuth erlauben)"
# entferne mögliche führende Kommentarzeichen oder passe an
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config || true
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config || true
# optional: erlauben, dass PAM genutzt wird
sed -i 's/^#\?UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config || true

# Root-Passwort setzen
if [ -n "$ROOT_PASSWORD" ]; then
  echo "==> Setze Root-Passwort"
  echo "root:${ROOT_PASSWORD}" | chpasswd
else
  echo "WARN: ROOT_PASSWORD ist leer. Root-Passwort wird nicht geändert."
fi

# Benutzer anlegen / Passwort setzen
if id -u "$HTL_USER" >/dev/null 2>&1; then
  echo "==> Benutzer $HTL_USER existiert bereits, Passwort wird gesetzt"
else
  echo "==> Lege Benutzer $HTL_USER an"
  adduser --gecos "" --disabled-password "$HTL_USER"
fi

if [ -n "$HTL_PASSWORD" ]; then
  echo "==> Setze Passwort für $HTL_USER"
  echo "${HTL_USER}:${HTL_PASSWORD}" | chpasswd
else
  echo "WARN: HTL_PASSWORD ist leer. Passwort für $HTL_USER wird nicht gesetzt."
fi

# optional: Home-Verzeichnis-Berechtigungen fixen
chown -R "${HTL_USER}:${HTL_USER}" /home/"${HTL_USER}" 2>/dev/null || true

echo "==> Starte sshd"
/usr/sbin/sshd -D