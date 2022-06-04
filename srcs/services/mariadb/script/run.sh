#!/bin/sh

sh /tmp/install.sh

#	--bind-address=0.0.0.0
#		allow every address to connect
#	-u mysql
#		the system user account who will run the server,
#		mandatory when running as root
#	-v
#		more information logging
MYSQLD_OPT="
	--bind-address=0.0.0.0
	-u mysql
	-v
"

# replace the current shell process with the mysql server
exec mysqld $MYSQLD_OPT
