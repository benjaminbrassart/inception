#!/bin/sh

WP_PATH='/var/www/html'

set -e
set -x

if ! wp core is-installed --path="$WP_PATH" 2> /dev/null; then
	rm -rf "$WP_PATH"/*

	wp core download --path="$WP_PATH"

	cd "$WP_PATH"

	wp config create \
		--dbname="$WP_DB_NAME" \
		--dbuser="$WP_DB_USER" \
		--dbpass="$WP_DB_PASSWORD" \
		--dbhost="inception_mariadb" \
		--debug
	wp db create #! database already created
	wp core install \
		--url="bbrassar.42.fr"
		--title="$WP_TITLE"
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email
	# TODO add user accounts
	# TODO install plugins and themes

	cd -
fi

exec php-fpm7 -F -y /etc/php7/php-fpm.conf
