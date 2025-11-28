#!/bin/bash

set -e

signal_terminate() {
	mariadb-admin shutdown &
	wait $!
	echo "Mariadb shutdown complete."
}

# SIGTERM is default signal sent by Docker when stopping a container
trap "signal_terminate" SIGTERM

# Initialize MariaDB if not already done

echo "Initializing MariaDB database..."
mariadb-install-db \
	--auth-root-authentication-method=normal
chown -R mysql:mysql /var/lib/mysql /var/log/mysql
chmod 755 /var/lib/mysql /var/log/mysql
echo "MariaDB initialization completed."

echo "Starting MariaDB daemon..."
# Replace current process with mariadb daemon
# This keeps the container running until MariaDB is stopped
exec mariadbd &
wait $!
exit 1

