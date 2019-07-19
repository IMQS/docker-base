FROM imqs/java-base:8

# Allow Azkaban to perform Docker tasks
ENV DOCKERVERSION=18.09.3
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

COPY . /azkaban
WORKDIR /azkaban
CMD ./bin/internal/internal-start-solo-server.sh
