FROM alpine:3.16

LABEL maintainer="bbrassar@student.42.fr"

COPY script/run.sh /tmp/run.sh
COPY script/install.sh /tmp/install.sh

RUN apk -U upgrade && apk add --no-cache mariadb mariadb-client

# we are force to use a script that will run after
# starting the container, because installing mysql
# requires the container to be running
ENTRYPOINT [ "sh", "/tmp/run.sh" ]
