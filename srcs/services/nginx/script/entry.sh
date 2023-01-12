#!/bin/sh

mkdir -p /var/log/nginx
touch /var/log/nginx/access.log /var/log/nginx/error.log

exec nginx -g 'daemon off;'
