# ssh/Dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND}

# Basis-Tools + OpenSSH installieren
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      nano wget curl less iputils-ping net-tools iproute2 dnsutils traceroute \
      netcat-openbsd openssh-server ca-certificates tzdata sudo passwd \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/run/sshd

# Copy startup script
COPY setup-ssh.sh /usr/local/bin/setup-ssh.sh
RUN chmod +x /usr/local/bin/setup-ssh.sh

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-ssh.sh"]
