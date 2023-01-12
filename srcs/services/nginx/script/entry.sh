#!/bin/sh

ADMINER_URL='https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php'
ADMINER_PLUGIN_URL='https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php'
LOGIN_SERVERS_URL='https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php'

download_file() {
    [ -f "$2" ] || curl -L "$1" -o "$2"
}

mkdir -p /var/log/nginx
touch /var/log/nginx/access.log /var/log/nginx/error.log

download_file "${ADMINER_URL}" 'adminer.php'
download_file "${ADMINER_PLUGIN_URL}" 'plugins/plugin.php'
download_file "${LOGIN_SERVERS_URL}" 'plugins/login-servers.php'

exec nginx -g 'daemon off;'
