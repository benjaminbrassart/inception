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
	curl php7 php7-fpm php7-pdo

RUN mkdir -p /var/www

# download and extract wordpress at the same time
RUN curl -Lso - https://wordpress.org/latest.tar.gz | \
	tar xvzf - -C /var/www

RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT [ "php-fpm7", "-F" ]
