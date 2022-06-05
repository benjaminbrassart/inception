# since alpine 3.16, php7 packages are on the testing branch (wtf?)
FROM alpine:3.15

LABEL maintainer="bbrassar@student.42.fr"

# create a user that will run php-fpm
#  options:
#   -S -> create a system account
#   -D -> do not create home directory
#   -H -> do not create home directory
RUN adduser -SDH www-data

# https://make.wordpress.org/hosting/handbook/server-environment/
RUN apk -U upgrade && apk add --no-cache \
	php7 php7-fpm php7-mysqlnd php7-json \
	php7-curl php7-dom php7-exif php7-fileinfo \
	php7-imagick php7-mbstring php7-openssl \
	php7-xml php7-zip php7-iconv php7-intl \
	php7-simplexml php7-sodium php7-xmlreader \
	php7-zlib php7-ssh2 php7-ftp php7-sockets \
	php7-session curl imagemagick

RUN rm -rf /etc/php7/php-fpm.d
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf

RUN mkdir -p /var/www

# download and extract wordpress at the same time
# TODO let script handle that
RUN curl -Lso - https://wordpress.org/latest.tar.gz | \
	tar xvzf - -C /var/www && \
	mv /var/www/wordpress /var/www/html && \
	chown -R www-data:www-data /var/www/html

ENTRYPOINT [ "php-fpm7", "-F", "-y", "/etc/php7/php-fpm.conf" ]
