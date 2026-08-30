#-------------------------------------------------------------------------------
#
#  Pre-conditions
#	1) Ports are to be set in the compose file
#
#-------------------------------------------------------------------------------

FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

# The image comes with a bare minimum Ubuntu distro. Some addidtional software 
# is needed for apt to work effectively.So, we install & enable apt-file first
RUN apt-get -y update
RUN apt-get -y install apt-file
RUN apt-file -y update
# And also install apt-utils
RUN apt-get -y install apt-utils

# The image comes with the unixodbc package preinstalled, but you have to 
# install the unixodbc-dev package on top of that, in order to accommodate inter-database comms. 
# Here are the steps to install unixodbc-dev, and a corresponding pgsql driver:
RUN apt-get -y install unixodbc-dev
RUN apt-get -y install odbc-postgresql

# We have to configure the odbc connection to postgres, by appending to the /etc/odbc.ini file:
RUN echo "[WIP] \n\
Driver     = /usr/lib/x86_64-linux-gnu/odbc/psqlodbcw.so \n\
Servername = dockerbootstrap_db_1 \n\
Port       = 5432 \n\
Database   = wip \n\
Username   = imqs \n\
Password   = 1mq5p@55w0rd" >> /etc/odbc.ini

ENTRYPOINT [ "/opt/mssql/bin/sqlservr" ]
