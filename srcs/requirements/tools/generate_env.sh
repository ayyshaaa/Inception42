#!/bin/bash
#Generate a .env file with environment variables for Docker Compose from ../secrets/ folder
#Check if variable unset/empty, print in fd2 (stderr)

MYSQL_DATABASE=$(grep -m1 '^db_name=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_DATABASE:-}" ]; then
    echo "ERROR: db_name not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

MYSQL_ROOT_PASSWORD=$(cat ~/inception/secrets/db_root_password.txt | sed 's/[[:space:]]*$//')
if [ -z "${MYSQL_ROOT_PASSWORD:-}" ]; then
    echo "ERROR: db_root_password.txt is empty or not found" >&2
    exit 1
fi

MYSQL_USER=$(grep -m1 '^db_user=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')

if [ -z "${MYSQL_USER:-}" ]; then
    echo "ERROR: db_user not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

MYSQL_PASSWORD=$(cat ~/inception/secrets/db_password.txt | sed 's/[[:space:]]*$//')
if [ -z "${MYSQL_PASSWORD:-}" ]; then
    echo "ERROR: db_password.txt is empty" >&2
    exit 1
fi

WORDPRESS_ADMIN_NAME=$(grep -m1 '^wp_admin_name=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_ADMIN_NAME:-}" ]; then
    echo "ERROR: wp_admin_name not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

WORDPRESS_ADMIN_PASSWORD=$(cat ~/inception/secrets/wp_admin_password.txt | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_ADMIN_PASSWORD:-}" ]; then
    echo "ERROR: wp_admin_password.txt is empty" >&2
    exit 1
fi

WORDPRESS_ADMIN_EMAIL=$(grep -m1 '^wp_admin_email=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_ADMIN_EMAIL:-}" ]; then
    echo "ERROR: wp_admin_email not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

WORDPRESS_USER_NAME=$(grep -m1 '^wp_user_name=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_USER_NAME:-}" ]; then
    echo "ERROR: wp_user_name not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

WORDPRESS_USER_PASSWORD=$(cat ~/inception/secrets/wp_password.txt | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_USER_PASSWORD:-}" ]; then
    echo "ERROR: wp_user_password.txt is empty" >&2
    exit 1
fi

WORDPRESS_USER_EMAIL=$(grep -m1 '^wp_user_email=' ~/inception/secrets/credentials.txt | cut -d '=' -f2 | sed 's/[[:space:]]*$//')
if [ -z "${WORDPRESS_USER_EMAIL:-}" ]; then
    echo "ERROR: wp_user_email not found in ~/inception/secrets/credentials.txt" >&2
    exit 1
fi

WORDPRESS_DB_HOST="db"

cat <<EOF > .env
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_USER=${MYSQL_USER}
MYSQL_PASSWORD=${MYSQL_PASSWORD}

WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
WORDPRESS_DB_USER=${MYSQL_USER}
WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}
WORDPRESS_DB_NAME=${MYSQL_DATABASE}

WORDPRESS_ADMIN_NAME=${WORDPRESS_ADMIN_NAME}
WORDPRESS_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD}
WORDPRESS_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL}
WORDPRESS_USER_NAME=${WORDPRESS_USER_NAME}
WORDPRESS_USER_PASSWORD=${WORDPRESS_USER_PASSWORD}
WORDPRESS_USER_EMAIL=${WORDPRESS_USER_EMAIL}

DOMAIN_NAME=aistierl.42.fr
EOF

mv .env ../..

exit 0

