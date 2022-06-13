#!/bin/sh

if [ ! -f /var/log/proftpd/proftpd.log ]; then
	mkdir -p /var/log/proftpd
	touch /var/log/proftpd/proftpd.log
fi

exec proftpd -n -d10
