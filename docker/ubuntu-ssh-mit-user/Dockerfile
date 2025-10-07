# Basis-Image: Ubuntu 24.04
FROM ubuntu:24.04

# Nicht-interaktive Installation (verhindert Abfragen bei apt)
ENV DEBIAN_FRONTEND=noninteractive

# Pakete installieren
RUN apt-get update && apt-get install -y \
    nano \
    openssh-server \
    net-tools \
    iputils-ping \
    htop \
    adduser \
    passwd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# SSH-Service-Verzeichnis
RUN mkdir -p /var/run/sshd

# Entrypoint-Skript kopieren
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]