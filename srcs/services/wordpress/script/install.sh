#!/bin/sh

WP_PATH='/var/www/html'

set -e

if [ ! -d "$WP_PATH" ]; then
	wp core download --path="$WP_PATH"
	cd "$WP_PATH"

	# TODO create config
	# TODO create db
	# TODO install
	# TODO add user accounts
	# TODO install plugins and themes

	cd -
fi

exec php-fpm7 -F -y /etc/php7/php-fpm.conf
