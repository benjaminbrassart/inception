FROM alpine:3.15.6

LABEL maintainer="bbrassar@student.42.fr"

ARG ADMINER_DIR=/var/www/adminer

RUN apk -U upgrade && apk add --no-cache nginx openssl curl

# generate self-signed ssl key-certificate pair
RUN openssl req -x509 -newkey rsa:4096 \
	-keyout /etc/ssl/certs/inception.key \
	-out /etc/ssl/certs/inception.crt \
	-sha256 -days 365 -nodes \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/CN=bbrassar.42.fr'

RUN mkdir -p ${ADMINER_DIR}/plugins

COPY php/adminer/index.php ${ADMINER_DIR}/index.php
COPY conf/bbrassar.conf /etc/nginx/http.d/default.conf
COPY script/entry.sh /tmp/entry.sh
COPY html/* /var/www/portfolio/

WORKDIR ${ADMINER_DIR}

ENTRYPOINT [ "sh", "/tmp/entry.sh" ]
