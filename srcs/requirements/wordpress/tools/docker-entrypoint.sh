#!/bin/sh

set -e

cd /var/www/html

echo "Proceeding with WordPress installation..."
if [ ! -f wp-config.php ] || [ ! -f .wp-installed-flag  ]; then
	php -d memory_limit=256M /usr/local/bin/wp core download --allow-root

	wp config create --dbname="$WORDPRESS_DB_NAME" \
   		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST" \
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

	touch .wp-installed-flag
else
	echo "WordPress is already installed, skipping installation."
fi

chown -R www-data:www-data /var/www/html

sed -i "s/^listen = .*/listen = 9000/" /etc/php*/php-fpm.d/www.conf
sed -i "s/^user = .*/user = www-data/" /etc/php*/php-fpm.d/www.conf
sed -i "s/^group = .*/group = www-data/" /etc/php*/php-fpm.d/www.conf

echo "Starting WordPress..."
echo "Executing: $@"
exec "$@"
