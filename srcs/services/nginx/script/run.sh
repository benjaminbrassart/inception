#!/bin/sh

set -e

ADMINER_URL='https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php'
ADMINER_DIR='/var/www/html/adminer'

if [ ! -f "$ADMINER_DIR/index.php" ]; then
	mkdir -p "$ADMINER_DIR"
	curl -L "$ADMINER_URL" -o "$ADMINER_DIR/index.php"
fi

exec nginx -g 'daemon off;'
