FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get dist-upgrade -y 
RUN apt-get install curl -y