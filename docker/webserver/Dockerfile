ARG PHP_VERSION=8.4
FROM ubuntu:24.04

ARG PHP_VERSION
ENV DEBIAN_FRONTEND=noninteractive

# Basis-Tools, PPA für neuere PHP-Versionen, Apache, PHP, SSH, supervisor, openssl
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    software-properties-common ca-certificates apt-transport-https curl gnupg lsb-release \
 && add-apt-repository ppa:ondrej/php -y \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    apache2 \
    libapache2-mod-php${PHP_VERSION} php${PHP_VERSION}-cli \
    php${PHP_VERSION}-gd php${PHP_VERSION}-mbstring php${PHP_VERSION}-xml php${PHP_VERSION}-curl \
    openssh-server supervisor openssl \
 && a2enmod ssl rewrite headers \
 && rm -rf /var/lib/apt/lists/*

# sshd benötigt dieses Verzeichnis
RUN mkdir -p /var/run/sshd

# default webroot und Berechtigungen
ARG CONTAINER_WEBROOT=/var/www/html
RUN mkdir -p ${CONTAINER_WEBROOT} \
 && chown -R www-data:www-data ${CONTAINER_WEBROOT}

# Konfigurationsdateien kopieren
COPY apache-default.conf /etc/apache2/sites-available/000-default.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY supervisor-apache-sshd.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443 22

VOLUME ["${CONTAINER_WEBROOT}"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["supervisord","-n"]