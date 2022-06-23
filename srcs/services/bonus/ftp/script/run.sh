#!/bin/sh

set -x

if [ ! -f /var/log/proftpd/proftpd.log ]; then
	mkdir -p /var/log/proftpd
	touch /var/log/proftpd/proftpd.log
fi

# Options
#	--passwd
#		set mode to user password
#	--force
#		overwrite passwd file content
#	--file=
#		use passwd file instead of default
#	--name=
#		name of the user
#	--uid=
#		id of the user
#	--gid=
#		id of the user's group
#	--home=
#		home of the virtual user
#	--shell=
#		shell of the virtual user
#	--stdin
#		read password from stdin rather that prompting
#
# see https://ixnfo.com/en/configuring-proftpd-with-virtual-users-in-a-file.html

FTPASSWD_OPT="
	--passwd
	--force
	--file=/etc/proftpd/ftpd.passwd
	--name=$FTP_USER
	--uid=0
	--gid=0
	--home=/srv
	--shell=/bin/false
	--stdin
"

# shellcheck disable=2086
echo "$FTP_PASSWORD" | ftpasswd $FTPASSWD_OPT


exec proftpd -n -d10 2>&1 | tee -a /var/log/proftpd/proftpd.log
