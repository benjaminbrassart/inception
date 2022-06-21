FROM alpine:3.16
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

# as of alpine 3.16, php7 is not in the community repository anymore
# https://gitlab.alpinelinux.org/alpine/aports/-/commit/dd0e687c7a10a50a70736ae8b715c5e8911e8630
# https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.16.0#php7_moved_to_testing
RUN apk -U upgrade && apk add --no-cache --repository="${ALPINE_REPO_TESTING}" \
	php7 php7-fpm php7-mysqli php7-json \
	php7-curl php7-dom php7-exif php7-fileinfo \
	php7-imagick php7-mbstring php7-openssl \
	php7-xml php7-zip php7-iconv php7-intl \
	php7-simplexml php7-sodium php7-xmlreader \
	php7-zlib php7-ssh2 php7-ftp php7-sockets \
	php7-session php7-phar php7-tokenizer
RUN apk add --no-cache \
	curl imagemagick mariadb-client fcgi

# THEY RENAMED THE BINARY 'php' TO 'php7' WHEN MOVING IT TO TESTING
# *angry developer noises*
RUN ln -s /usr/bin/php7 /usr/bin/php

RUN rm -rf /etc/php7/php-fpm.d
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf

RUN mkdir -p /var/www

# https://wp-cli.org/
RUN curl -Lo /usr/bin/wp ${WPCLI_URL} && chmod +x /usr/bin/wp

COPY script/install.sh /tmp/install.sh

# ENTRYPOINT [ "php-fpm7", "-F", "-y", "/etc/php7/php-fpm.conf" ]
ENTRYPOINT [ "sh", "/tmp/install.sh" ]
