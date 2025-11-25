#!/bin/bash
#Generate a .env file with environment variables for Docker Compose from ../secrets/ folder
#Check if variable unset/empty, print in fd2 (stderr)

MYSQL_DATABASE=$(grep -m1 '^db_name=' ../secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_DATABASE:-}" ]; then
    echo "ERROR: db_name not found in ../secrets/credentials.txt" >&2
    exit 1
fi

MYSQL_ROOT_PASSWORD=$(cat ../secrets/db_root_password.txt | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_ROOT_PASSWORD:-}" ]; then
    echo "ERROR: db_root_password.txt is empty or not found" >&2
    exit 1
fi

MYSQL_USER=$(grep -m1 '^db_user=' ../secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_USER:-}" ]; then
    echo "ERROR: db_user not found in ../secrets/credentials.txt" >&2
    exit 1
fi

MYSQL_PASSWORD=$(cat ../secrets/db_password.txt | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_PASSWORD:-}" ]; then
    echo "ERROR: db_password.txt is empty" >&2
    exit 1
fi

WORDPRESS_DB_HOST="mariadb:3306"

cat <<EOF > .env
MYSQL_DATABASE=$MYSQL_DATABASE
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
MYSQL_USER=$MYSQL_USER
MYSQL_PASSWORD=$MYSQL_PASSWORD

WORDPRESS_DB_HOST=$WORDPRESS_DB_HOST
WORDPRESS_DB_USER=$MYSQL_USER
WORDPRESS_DB_PASSWORD=$MYSQL_PASSWORD
WORDPRESS_DB_NAME=$MYSQL_DATABASE

DOMAIN_NAME=aistierl.42.fr
EOF

exit 0

