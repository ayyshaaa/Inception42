#!/bin/sh

set -e

wp core download --path=/var/www/html --allow-root
wp config create --path=/var/www/html --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --allow-root
wp core install --path=/var/www/html \
    --url="http://$DOMAIN_NAME" \
    --title="Inception" \
    --admin_user="$WORDPRESS_ADMIN_NAME" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --locale="fr_FR" \
    --skip-email \
    --allow-root
wp user create "$WORDPRESS_USER_NAME" "$WORDPRESS_USER_EMAIL" \
    --user_pass="$WORDPRESS_USER_PASSWORD" --role="author" --allow-root

chown -R www-data:www-data /var/www/html
