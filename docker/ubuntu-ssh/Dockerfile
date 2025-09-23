# Basis-Image: Ubuntu 24.04
FROM ubuntu:24.04

# Nicht-interaktive Installation (verhindert Abfragen bei apt)
ENV DEBIAN_FRONTEND=noninteractive

# Pakete aktualisieren und gewünschte Tools installieren
RUN apt-get update && apt-get install -y \
    nano \
    openssh-client \
    openssh-server \
    net-tools \
    iputils-ping \
    htop \
    adduser \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# SSH-Service konfigurieren
RUN mkdir /var/run/sshd

# Root-Login per SSH mit Passwort erlauben (nur zu Testzwecken!)
RUN echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Standard-Port für SSH
EXPOSE 22

# Startet SSH beim Container-Start
CMD ["/usr/sbin/sshd", "-D"]