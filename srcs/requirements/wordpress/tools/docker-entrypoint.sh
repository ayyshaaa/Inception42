#!/bin/sh

set -e

if [ ! -f /var/www/html/wp-config.php ]; then
	php -d memory_limit=256M /usr/local/bin/wp core download --allow-root

	wp config create --dbname="$WORDPRESS_DB_NAME" \
   		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST:3306" \
		--locale="fr_FR" \
		--allow-root

	wp core install --url="http://$DOMAIN_NAME" \
		--title="Inception" \
		--admin_user="$WORDPRESS_ADMIN_NAME" \
		--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--skip-email \
		--allow-root

	wp user create "$WORDPRESS_USER_NAME" "$WORDPRESS_USER_EMAIL" \
		--user_pass="$WORDPRESS_USER_PASSWORD" \
		--role="author" \
		--allow-root

	wp language core install fr_FR --allow-root
	wp site switch-language fr_FR --allow-root
fi

chown -R www-data:www-data /var/www/html
