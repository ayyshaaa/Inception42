#!/bin/bash
# This script runs during MariaDB initialization

echo "Creating database and user from environment variables..."

mariadb -u root --socket=/var/run/mysqld/mysqld.sock <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    
    -- Set root password for TCP connections
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    
    FLUSH PRIVILEGES;
EOSQL

echo "Database ${MYSQL_DATABASE} and user ${MYSQL_USER} created successfully. Root password set."