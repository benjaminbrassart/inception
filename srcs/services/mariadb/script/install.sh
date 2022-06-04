#!/bin/sh

# TODO check if already installed

# https://mariadb.com/kb/en/mysql_install_db/#options
mysql_install_db								\
	--auth-root-authentication-method=socket	\
	--basedir=/usr								\
	--datadir=/var/lib/mysql					\
	--skip-test-db								\
	--user=mysql								\
	--verbose
