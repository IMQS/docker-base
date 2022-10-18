# sudo docker build -t imqs/postgres-upgrade:10-to-11 .

FROM postgres:11

RUN sed -i 's/$/ 10/' /etc/apt/sources.list.d/pgdg.list

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" | \
	tee /etc/apt/sources.list.d/backports.list && \
	apt-get update --fix-missing && \
	apt-get install -y postgis postgresql-11-postgis-3 postgresql-10-postgis-3 \
					   postgresql-server-dev-11 postgresql-server-dev-10 \
					   jq netcat-openbsd cron locales locales-all \
					   libcurl4-openssl-dev \
					   git build-essential make clang-6.0 && \
	rm -rf /var/lib/apt/lists/*

ENV PGBINOLD /usr/lib/postgresql/10/bin
ENV PGBINNEW /usr/lib/postgresql/11/bin

ENV PGDATAOLD /var/lib/postgresql/10/data
ENV PGDATANEW /var/lib/postgresql/11/data

RUN mkdir -p "$PGDATAOLD" "$PGDATANEW" \
	&& chown -R postgres:postgres /var/lib/postgresql

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/

ENTRYPOINT ["docker-upgrade"]

# recommended: --link
CMD ["pg_upgrade"]
