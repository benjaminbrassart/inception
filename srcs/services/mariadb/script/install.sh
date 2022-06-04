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
	--auth-root-authentication-method=socket
	--basedir=/usr
	--datadir=/var/lib/mysql
	--skip-test-db
	--user=mysql
	--verbose
"

# abort when an error occurs
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
	mysql_install_db $MYSQL_INSTALL_OPT
fi

# delete default configs
> /etc/my.cnf
rm -rf /etc/my.cnf.d
