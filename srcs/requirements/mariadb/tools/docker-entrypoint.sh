#!/bin/bash
set -e

# Initialize MariaDB if data directory is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld
    chmod 755 /var/lib/mysql /var/log/mysql /var/run/mysqld
    mariadb-install-db --user="$MYSQL_USER" --datadir=/var/lib/mysql
    
    if [ -d "/docker-entrypoint-initdb.d" ] && [ "$(ls -A /docker-entrypoint-initdb.d 2>/dev/null)" ]; then
        mariadbd --user="$MYSQL_USER" --skip-networking --socket=/var/run/mysqld/mysqld.sock --datadir=/var/lib/mysql &
        mariadb_pid=$!
	echo "Waiting for MariaDB socket..."
	for i in {1...30}; do
		if mariadb-admin -u root --socket=/var/run/mysqld/mysqld.sock ping 2>/dev/null; then
			echo "MariaDB is ready"
			break;
		fi
		sleep 1
	done
        chmod +x /docker-entrypoint-initdb.d/01-init-database.sh
        /docker-entrypoint-initdb.d/01-init-database.sh
        echo "Initialization scripts complete."
        mariadb-admin -u root --password="$MYSQL_ROOT_PASSWORD" --socket=/var/run/mysqld/mysqld.sock shutdown 2>/dev/null || true
        wait $mariadb_pid 2>/dev/null || true
        sleep 2
    fi
else
    echo "MariaDB data directory exists, skipping initialization."
    chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld
fi

echo "Starting MariaDB..."
echo "Executing: $@"
exec "$@"
