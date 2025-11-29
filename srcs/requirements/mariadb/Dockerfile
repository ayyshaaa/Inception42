FROM alpine:3.21.5

RUN apk upgrade && \
	apk update && \
	apk add --no-cache bash

#log, socket file and initdb directory
RUN mkdir -p /var/log/mysql /var/run/mysqld /docker-entrypoint-initdb.d

RUN apk add --no-cache \
	mariadb \
	mariadb-client

#COPY ./requirements/mariadb/tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
#COPY ./requirements/mariadb/tools/init-database.sh /docker-entrypoint-initdb.d/01-init-database.sh
#COPY ./requirements/mariadb/conf/my.cnf /etc/my.cnf
#COPY ./requirements/mariadb/conf/my.cnf.d/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/init-database.sh /docker-entrypoint-initdb.d/01-init-database.sh
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./conf/my.cnf.d/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
