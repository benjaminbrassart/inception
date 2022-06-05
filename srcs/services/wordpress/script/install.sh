#!/bin/sh

WP_PATH='/var/www/html'

set -e

if [ ! -d "$WP_PATH" ]; then
	wp core download --path="$WP_PATH"
	cd "$WP_PATH"

	# https://developer.wordpress.org/cli/commands/config/create/
	wp config create \
		--dbname="$WP_DB_NAME" \
		--dbuser="$WP_DB_USER" \
		--dbpass="$WP_DB_PASSWORD" \
		--dbhost="inception_mariadb" \
		--debug
	wp db create
	# TODO add user accounts
	# TODO install plugins and themes

	cd -
fi

exec php-fpm7 -F -y /etc/php7/php-fpm.conf
