#!/bin/sh

set -e

ADMINER_DIR='/var/www/html/adminer'

ADMINER_URL='https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php'
ADMINER_PLUGIN_URL='https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php'
LOGIN_SERVERS_URL='https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php'

if [ ! -f "$ADMINER_DIR/adminer.php" ]; then
	mkdir -p "$ADMINER_DIR/plugins"
	cp /tmp/index.php "$ADMINER_DIR/index.php"
	curl -L "$ADMINER_URL" -o "$ADMINER_DIR/adminer.php"
	curl -L "$ADMINER_PLUGIN_URL" -o "$ADMINER_DIR/plugins/plugin.php"
	curl -L "$LOGIN_SERVERS_URL" -o "$ADMINER_DIR/plugins/login-servers.php"
fi

# forced to do this contraption because we can't copy directly to a volume
for file in /tmp/html/*; do
	file_basename="$(basename "$file")"
	volume_file="/var/www/html/$file_basename"

	if [ ! -f "$volume_file" ] || [ "$file" -nt "$volume_file" ]; then
		printf -- "$file_basename has changed, copying\n"
		cp "$file" "$volume_file"
	fi
done

exec nginx -g 'daemon off;'
