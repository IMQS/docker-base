# docker build -t imqs/java-base:8 .
FROM imqs/ubuntu-base

ARG JAVA_VERSION=8
ARG JAVA_BUILD=482
ARG JAVA_URL=https://api.adoptium.net/v3/binary/version/jdk8u482-b08/linux/x64/jre/hotspot/normal/eclipse

RUN apt-get update \
    && apt-get install -y curl ca-certificates tar \
    && curl -fsSL "$JAVA_URL" -o /tmp/java.tar.gz \
    && mkdir -p /opt/java \
    && tar -xzf /tmp/java.tar.gz -C /opt/java --strip-components=1 \
    && rm -f /tmp/java.tar.gz \
    && ln -s /opt/java/bin/java /usr/local/bin/java \
    && java -version \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /imqsvar \
    && ln -s /var/log/imqs /imqsvar/logs
