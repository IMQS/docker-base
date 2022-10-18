# sudo docker build -t imqs/postgres-upgrade:10-to-14 .

FROM postgres:14

RUN sed -i 's/$/ 10/' /etc/apt/sources.list.d/pgdg.list

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" | \
	tee /etc/apt/sources.list.d/backports.list && \
	apt-get update --fix-missing && \
	apt-get install -y postgis postgresql-14-postgis-3 postgresql-10-postgis-3 \
					   postgresql-server-dev-14 postgresql-server-dev-10 \
					   jq netcat-openbsd cron locales locales-all \
					   libcurl4-openssl-dev \
					   git build-essential make clang-11 && \
	rm -rf /var/lib/apt/lists/*

ENV PGBINOLD /usr/lib/postgresql/10/bin
ENV PGBINNEW /usr/lib/postgresql/14/bin

ENV PGDATAOLD /var/lib/postgresql/10/data
ENV PGDATANEW /var/lib/postgresql/14/data

RUN mkdir -p "$PGDATAOLD" "$PGDATANEW" \
	&& chown -R postgres:postgres /var/lib/postgresql

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/

ENTRYPOINT ["docker-upgrade"]

# recommended: --link
CMD ["pg_upgrade"]
