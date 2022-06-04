#!/bin/sh

set -e

if [ ! -d /run/mysqld ]; then
	mkdir /run/mysqld
	chown mysql:mysql /run/mysqld
fi

printf -- "Installing MariaDB\n"
if [ -d /var/lib/mysql/mysql ]; then
	printf -- "MariaDB already installed, skipping\n"
else
	# https://mariadb.com/kb/en/mysql_install_db/#options
	mysql_install_db								\
		--auth-root-authentication-method=socket	\
		--basedir=/usr								\
		--datadir=/var/lib/mysql					\
		--skip-test-db								\
		--user=mysql								\
		--verbose
fi

exec mysqld -v -u mysql
