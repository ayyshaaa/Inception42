#!/bin/bash
set -e

# Initialize MariaDB if data directory is empty
if [ ! -d "/var/lib/mysql" ]; then
    echo "Initializing MariaDB database..."
    chown -R $MYSQL_USER:$MYSQL_USER /var/lib/mysql /var/log/mysql /var/run/mysqld
    chmod 755 /var/lib/mysql /var/log/mysql /var/run/mysqld
    mariadb-install-db --user=$MYSQL_USER
    if [ -d "/docker-entrypoint-initdb.d" ] && [ "$(ls -A /docker-entrypoint-initdb.d 2>/dev/null)" ]; then
        mariadbd --user=$MYSQL_USER --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    	temp_pid=$!
	sleep 1
	chmod +x /docker-entrypoint-initdb.d/01-init-database.sh
	/docker-entrypoint-initdb.d/01-init-database.sh
	echo "Initialization complete."
	mariadb-admin -u root --socket=/var/run/mysqld/mysqld.sock --password=$MYSQL_ROOT_PASSWORD shutdown
	wait $temp_pid
    fi
else
    echo "MariaDB data directory exists, skipping initialization."
    chown -R $MYSQL_USER:$MYSQL_USER /var/lib/mysql /var/log/mysql /var/run/mysqld
fi

echo "Starting MariaDB..."
