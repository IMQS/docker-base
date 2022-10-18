# Postgres Upgrade using Docker

The postgres-upgrade images are of the format `OLD-to-NEW`, where `OLD` represents the version of PostgreSQL you are _currently_ running, and `NEW` represents the version of PostgreSQL you would like to upgrade to.

## Before running the postgres upgrade

It is important that the following criteria is met before starting the postgres upgrade.

- Stop all running instances of the database.

- Rename the current data folder

You can rename your current data folder to the version of PostgreSQL you are currently running.

For example, rename `db-data` to `db10-data`, which assumes that your current data folder is named `db-data` and you are currently running version 10 of PostgreSQL.

## Upgrading postgres

The following commands should be run in the directory that contains the data folder of the database that needs to be upgraded.

```
docker run --rm \
	-v PGDATAOLD:/var/lib/postgresql/OLD/data \
	-v PGDATANEW:/var/lib/postgresql/NEW/data \
	imqs/postgres-upgrade:OLD-to-NEW
```
Where `PGDATAOLD` is the directory where your current data folder is and `PGDATANEW` is the directory where your new data folder will be.

Example of actual commands to run:

```
docker run --rm \
	-v ./db10-data:/var/lib/postgresql/10/data \
	-v ./db11-data:/var/lib/postgresql/11/data \
	imqs/postgres-upgrade:10-to-11
```
Which assumes that you are currently running version 10 of PostgreSQL and you would like to upgrade to version 11.

When the upgrade is complete, rename the new data folder to the original data folder's name. For example, `db11-data` will be renamed to `db-data`.
