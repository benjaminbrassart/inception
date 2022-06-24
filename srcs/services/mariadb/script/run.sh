#!/bin/sh

sh /tmp/install.sh

#	--bind-address=0.0.0.0
#		allow every address to connect
#	--disable-skip-networking
#		tell mariadb to listen for network connections
#	-u mysql
#		the system user account who will run the server,
#		mandatory when running as root
#	-v
#		more information logging
MYSQLD_OPT="
    --bind-address=0.0.0.0
    --disable-skip-networking
    --user mysql
    --verbose
"

# replace the current shell process with the mysql server
# shellcheck disable=2086
exec mariadbd ${MYSQLD_OPT}
