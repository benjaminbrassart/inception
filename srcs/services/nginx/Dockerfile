FROM alpine:3.15.6

LABEL maintainer="bbrassar@student.42.fr"

ARG ADMINER_DIR=/var/www/html/adminer

ARG ADMINER_URL=https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php
ARG ADMINER_PLUGIN_URL=https://raw.githubusercontent.com/vrana/adminer/master/plugins/plugin.php
ARG LOGIN_SERVERS_URL=https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php

RUN apk -U upgrade && apk add --no-cache nginx openssl curl

# generate self-signed ssl key-certificate pair
RUN openssl req -x509 -newkey rsa:4096 \
	-keyout /etc/ssl/certs/inception.key \
	-out /etc/ssl/certs/inception.crt \
	-sha256 -days 365 -nodes \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/CN=bbrassar.42.fr'

RUN \
	mkdir -p ${ADMINER_DIR}/plugins /var/log/nginx /var/lib/nginx/logs && \
	touch /var/log/nginx/error.log /var/lib/nginx/logs/error.log && \
	curl -L ${ADMINER_URL} -o ${ADMINER_DIR}/adminer.php \
	curl -L ${ADMINER_PLUGIN_URL} -o ${ADMINER_DIR}/plugins/plugin.php \
	curl -L ${LOGIN_SERVERS_URL} -o ${ADMINER_DIR}/plugins/login-servers.php

COPY php/adminer/index.php ${ADMINER_DIR}/index.php
COPY conf/bbrassar.conf /etc/nginx/http.d/default.conf

COPY html/* /var/www/html/

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
