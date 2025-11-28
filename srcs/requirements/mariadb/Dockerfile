FROM alpine:3.21.5

RUN apk update && \
	apk upgrade && \
	apk add --no-cache bash

COPY ./requirements/mariadb/tools/startNStop.sh /usr/local/bin/startNStop.sh
COPY ./requirements/mariadb/conf/my.cnf /etc/my.cnf
COPY ./requirements/mariadb/conf/my.cnf.d/mariadb.cnf /etc/my.cnf.d/mariadb.cnf

RUN mkdir -p /var/log/mysql

RUN apk add --no-cache \
	mariadb \
	mariadb-client && \
	chmod +x /usr/local/bin/startNStop.sh

ENTRYPOINT [ "/usr/local/bin/startNStop.sh" ]