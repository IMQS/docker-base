FROM ubuntu:18.04

RUN  apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y \
  curl \
  iputils-ping \
  netcat \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/imqs

# Tool to wait for network connection
COPY wait-for-nc.sh /usr/bin
# Tool to wait for postgres to accept connections
COPY wait-for-postgres.sh /usr/bin
