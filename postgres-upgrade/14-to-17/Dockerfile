# docker build -t imqs/postgres-upgrade:14-to-17 .

FROM postgres:17

RUN sed -i 's/$/ 14/' /etc/apt/sources.list.d/pgdg.list

RUN echo "deb http://ftp.debian.org/debian trixie-backports main" | \
	tee /etc/apt/sources.list.d/backports.list && \
	apt-get update --fix-missing && \
	apt-get install -y postgis postgresql-17-postgis-3 postgresql-14-postgis-3 \
					   postgresql-server-dev-17 postgresql-server-dev-14 \
					   jq netcat-openbsd cron locales locales-all \
					   libcurl4-openssl-dev \
					   git build-essential make clang-19 && \
	rm -rf /var/lib/apt/lists/*

ENV PGBINOLD=/usr/lib/postgresql/14/bin
ENV PGBINNEW=/usr/lib/postgresql/17/bin

ENV PGDATAOLD=/var/lib/postgresql/14/data
ENV PGDATANEW=/var/lib/postgresql/17/data

RUN mkdir -p "$PGDATAOLD" "$PGDATANEW" \
	&& chown -R postgres:postgres /var/lib/postgresql

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/

ENTRYPOINT ["docker-upgrade"]

# recommended: --link
CMD ["pg_upgrade"]
