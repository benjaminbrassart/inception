#!/bin/sh

# This script is made to install MariaDB default databases and users.
# It only exists because Docker volumes are mounted at runtime, not
# when building the container.

#	--auth-root-authentication-method=normal
#		force root the authenticate with a password
#
#	--basedir=/usr
#		where mysql will be installed (mainly for `bin` and `lib`)
#
#	--datadir=/var/lib/mysql
#		where mysql data will be stored (useful when mounting docker volumes)
#
#	--skip-test-db
#		avoid creating test database and anonymous user
#
#	--user=mysql
#		system user account which will be used to perform the installation
#
#	--verbose
#		more information logging
#
MYSQL_INSTALL_OPT="
	--auth-root-authentication-method=normal
	--basedir=/usr
	--datadir=/var/lib/mysql
	--skip-test-db
	--user=mysql
"

set -e -x

if [ ! -d /run/mysqld ]; then
	mkdir -p /run/mysqld
	chown mysql:mysql /run/mysqld
fi

printf -- "Installing MariaDB\n"
if [ -d /var/lib/mysql/mysql ]; then
	printf -- "MariaDB already installed, skipping\n"
else
	# https://mariadb.com/kb/en/mysql_install_db/#options
	mariadb-install-db $MYSQL_INSTALL_OPT

	# create empty init.sql
	init_file="$(mktemp -q)"
	# FLUSH PRIVILEGES is important, can't remember why though
	echo "FLUSH PRIVILEGES;" >> $init_file
	# create new user
	echo "CREATE USER '$WP_DB_USER'@'%' IDENTIFIED VIA mysql_native_password USING PASSWORD('$WP_DB_PASSWORD');" >> $init_file
	echo "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('$MARIADB_ROOT_PASSWORD');" >> $init_file
	# give all permissions to the new user
	echo "GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%';" >> $init_file
	# make request
	mysqld --user=mysql --bootstrap < $init_file
	# delete init.sql
	rm -f "$init_file"
fi

# delete default configs
> /etc/my.cnf
rm -rf /etc/my.cnf.d
