#!/bin/sh

set -e

if [ ! -e /var/www/html/index.php ] && [ ! -e /var/www/html/wp-includes/version.php ]; 
tar cf - -C /usr/src/wordpress . | tar xf - -C /var/www/html
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
#edit le .php et inserer les valeurs env
fi

#mariadb cli

#language fr au lieu de en
