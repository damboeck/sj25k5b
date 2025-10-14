# client/Dockerfile
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND}

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      openssh-client curl wget nano less iputils-ping net-tools iproute2 dnsutils traceroute \
      netcat-openbsd telnet sudo \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-l"]