# This is a docker container that is intended to be used for running unit tests
# Throw whatever you need in here, to make it easy to run your unit tests, in whatever language
# This container has no Jenkins build task. If you need to update it, just build it on
# your own machine and push it.
#
# docker build -t imqs/tester tester
# docker push imqs/tester
#
FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    ruby2.5 \
    ruby2.5-dev \
    wget

RUN wget -O /tmp/go.tar.gz https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

ENV PATH="${PATH}:/usr/local/go/bin"

RUN gem install \
    test-unit \
    rest-client
