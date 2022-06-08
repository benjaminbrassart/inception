#!/bin/sh

#	--auth-root-authentication-method=socket
#		allow root client login via unix socket only (local terminal)
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

init_file=/tmp/init.sql

# abort when an error occurs
set -e
# print what the hell is going on
set -x

if [ ! -d /run/mysqld ]; then
	mkdir /run/mysqld
	chown mysql:mysql /run/mysqld
fi

printf -- "Installing MariaDB\n"
if [ -d /var/lib/mysql/mysql ]; then
	printf -- "MariaDB already installed, skipping\n"
else
	# https://mariadb.com/kb/en/mysql_install_db/#options
	mysql_install_db $MYSQL_INSTALL_OPT

	> $init_file
	echo "FLUSH PRIVILEGES;" >> $init_file
	echo "CREATE USER '$WP_DB_USER'@'%' IDENTIFIED VIA mysql_native_password USING PASSWORD('$WP_DB_PASSWORD');" >> $init_file
	echo "GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%';" >> $init_file

	mysqld --user=mysql --bootstrap < $init_file
	rm -f "$init_file"
fi

# delete default configs
> /etc/my.cnf
rm -rf /etc/my.cnf.d
