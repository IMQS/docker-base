# BUILD stage

FROM gradle:7-jdk17 AS builder

WORKDIR /extbuilder
RUN git clone https://github.com/wiremock/wiremock-faker-extension.git .
RUN git remote add jerui1 https://github.com/jerui1/wiremock-faker-extension.git
RUN git fetch jerui1
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Name"
RUN git merge jerui1/feature/Allow-for-seeding-the-Faker-instance
RUN git merge jerui1/feature/Allow-users-to-specify-the-locale-for-fake-data
RUN ./gradlew shadowJar

WORKDIR /mainbuilder
RUN git clone https://github.com/wiremock/wiremock .
RUN sed -i /Xmx3g/d gradle.properties
RUN ./gradlew shadowJar

FROM eclipse-temurin:11.0.24_8-jre

WORKDIR /home/wiremock

COPY --from=builder /mainbuilder/build/libs/*.jar /var/wiremock/lib/wiremock-standalone.jar
COPY docker-entrypoint.sh /
RUN mkdir -p /home/wiremock/mappings && \
	mkdir -p /home/wiremock/__files && \
	mkdir -p /var/wiremock/extensions
COPY --from=builder /extbuilder/build/libs/*.jar /var/wiremock/extensions/
EXPOSE 8080 8443

HEALTHCHECK --start-period=5s --start-interval=100ms CMD curl -f http://localhost:8080/__admin/health || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]

