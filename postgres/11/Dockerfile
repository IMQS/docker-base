# sudo docker build -t imqs/postgres:11 .

FROM postgres:11

# Install dependencies and remove build dependencies
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" | \
	tee /etc/apt/sources.list.d/backports.list && \
	apt-get update --fix-missing && \
	apt-get install -y postgis postgresql-11-postgis-3 \
					   jq netcat-openbsd \
					   cron locales locales-all \
					   postgresql-server-dev-11 libcurl4-openssl-dev \
					   git build-essential make clang-6.0 && \
	git clone https://github.com/pramsey/pgsql-http.git && \
	cd pgsql-http && \
	ln -s /usr/include/postgresql/11 /usr/include/postgresql/12 && \
	rm -rf /usr/lib/postgresql/12 && \
	ln -s /usr/lib/postgresql/11 /usr/lib/postgresql/12 && \
	rm -rf /usr/share/postgresql/12 && \
	ln -s /usr/share/postgresql/11 /usr/share/postgresql/12 && \
	make && \
	make install && \
	apt-get remove -y postgresql-server-dev-11 git \
					  build-essential make clang-6.0 && \
	apt-get -y autoremove

COPY initdb /docker-entrypoint-initdb.d
RUN chmod 755 /docker-entrypoint-initdb.d/01-init.sh
RUN chmod 755 /docker-entrypoint-initdb.d/02-postgres-config-updater.sh
RUN chmod 755 /docker-entrypoint-initdb.d/03-postgres-replication-starter.sh

COPY pgmetrics /usr/bin

# add all scripts
ADD scripts/ /etc/scripts/

# add all crons
RUN mkdir -p /etc/cron.d
ADD crons/ /etc/cron.d/
RUN chmod -R 0644 /etc/cron.d

HEALTHCHECK --interval=5s --timeout=5s --retries=5 CMD pg_isready -U postgres

# enable cron as a sevice
RUN update-rc.d cron defaults
