FROM alpine:3.16

LABEL maintainer="bbrassar@student.42.fr"

RUN apk -U upgrade && apk add --no-cache nginx openssl curl

# generate self-signed ssl key-certificate pair
RUN openssl req -x509 -newkey rsa:4096 \
	-keyout /etc/ssl/certs/inception.key \
	-out /etc/ssl/certs/inception.crt \
	-sha256 -days 365 -nodes \
	-subj '/C=FR/ST=Ile-de-France/L=Paris/O=42/CN=bbrassar.42.fr'

COPY script/run.sh /tmp/run.sh
COPY php/adminer/index.php /tmp/index.php
COPY conf/bbrassar.conf /etc/nginx/http.d/default.conf

COPY html /tmp/html

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
