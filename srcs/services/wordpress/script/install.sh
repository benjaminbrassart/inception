#!/bin/sh

WP_PATH='/var/www/html/wordpress'

set -e
set -x

mkdir -p "$WP_PATH"

export WP_CLI_ALLOW_ROOT=1

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
	wp db create
	wp core install \
		--url="bbrassar.42.fr/wordpress" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email
	wp user create \
		"$WP_REGULAR_USER" \
		"$WP_REGULAR_EMAIL" \
		--user_pass="$WP_REGULAR_PASSWORD" \
		--porcelain

	# https://fr.wordpress.org/plugins/redis-cache/
	wp plugin install redis-cache
	wp plugin activate redis-cache
	wp plugin update redis-cache

	# https://github.com/rhubarbgroup/redis-cache/wiki/WP-CLI-Commands
	wp redis enable

	# https://github.com/rhubarbgroup/redis-cache/wiki/Connection-Parameters
	wp config set WP_REDIS_HOST inception_redis
	wp config set WP_REDIS_PORT 6379 --raw
	wp config set WP_REDIS_TIMEOUT 1 --raw
	wp config set WP_REDIS_READ_TIMEOUT 1 --raw
	wp config set WP_REDIS_DATABASE false --raw

	cd -
fi

exec php-fpm7 -F -y /etc/php7/php-fpm.conf
