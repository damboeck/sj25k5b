# syntax=docker/dockerfile:1
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=developer
ARG UID=1001
ARG GID=1001
ARG PUBKEY=""
# Optional: öffentlicher Schlüssel, z.B. "$(cat ~/.ssh/id_rsa.pub)" beim Build

ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND}

# Basis-Tools + OpenSSH installieren, Benutzer anlegen
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      nano wget curl less iputils-ping net-tools htop \
      openssh-server ca-certificates tzdata sudo passwd \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/run/sshd \
 && groupadd -g ${GID} ${USER} 2>/dev/null || true \
 && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USER} \
 && mkdir -p /home/${USER}/.ssh \
 && chmod 700 /home/${USER}/.ssh \
 && chown -R ${USER}:${USER} /home/${USER}

# (Unsicher) Default-Passwort für den Benutzer (nur für Entwicklung).
# In Produktion: entferne diese Zeile und nutze ausschließlich SSH keys!
RUN echo "${USER}:changeme" | chpasswd

# SSH Konfiguration: Root-Login verbieten, AuthorizedKeysFile setzen.
# Wenn beim Build ein PUBKEY übergeben wurde, wird PasswordAuthentication deaktiviert.
RUN { \
      echo "PermitRootLogin no"; \
      echo "AuthorizedKeysFile %h/.ssh/authorized_keys"; \
#      if [ -n \"$PUBKEY\" ]; then \
#        echo "PasswordAuthentication no"; \
#      else \
        echo "PasswordAuthentication yes"; \
#      fi; \
    } >> /etc/ssh/sshd_config

# Falls PUBKEY per build-arg mitgegeben wurde, in authorized_keys schreiben
RUN if [ -n "$PUBKEY" ]; then \
      printf "%s\n" "$PUBKEY" > /home/${USER}/.ssh/authorized_keys && \
      chown ${USER}:${USER} /home/${USER}/.ssh/authorized_keys && \
      chmod 600 /home/${USER}/.ssh/authorized_keys ; \
    fi

EXPOSE 22

# Ohne Systemd: SSHD im Vordergrund starten
CMD ["/usr/sbin/sshd","-D"]