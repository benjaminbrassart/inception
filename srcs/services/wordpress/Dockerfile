FROM alpine:3.15.2
#FROM alpine:3.15

LABEL maintainer="bbrassar@student.42.fr"

ARG WPCLI_URL="https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
ARG ALPINE_REPO_TESTING="https://dl-cdn.alpinelinux.org/alpine/edge/testing"

# create a user that will run php-fpm
#  options:
#   -S -> create a system account
#   -D -> do not create home directory
#   -H -> do not create home directory
RUN adduser -SDH www-data

# https://make.wordpress.org/hosting/handbook/server-environment/

RUN apk -U upgrade && apk add --no-cache \
	php7 php7-fpm php7-mysqli php7-json \
	php7-curl php7-dom php7-exif php7-fileinfo \
	php7-imagick php7-mbstring php7-openssl \
	php7-xml php7-zip php7-iconv php7-intl \
	php7-simplexml php7-sodium php7-xmlreader \
	php7-zlib php7-ssh2 php7-ftp php7-sockets \
	php7-session php7-phar php7-tokenizer \
	curl imagemagick mariadb-client fcgi

RUN rm -rf /etc/php7/php-fpm.d
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf

RUN mkdir -p /var/www

# https://wp-cli.org/
RUN curl -Lo /usr/bin/wp ${WPCLI_URL} && chmod +x /usr/bin/wp

COPY script/install.sh /tmp/install.sh

# ENTRYPOINT [ "php-fpm7", "-F", "-y", "/etc/php7/php-fpm.conf" ]
ENTRYPOINT [ "sh", "/tmp/install.sh" ]
