FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get dist-upgrade -y 
RUN apt-get install curl -y
RUN apt-get install postgresql-client -y
RUN apt-get install iputils-ping -y
RUN apt-get install netcat -y

RUN mkdir -p /var/log/imqs

# Tool to wait for network connection
COPY wait-for-nc.sh /usr/bin
# Tool to wait for postgres to accept connections
COPY wait-for-postgres.sh /usr/bin

