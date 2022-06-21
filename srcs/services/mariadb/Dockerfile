FROM alpine:3.16

LABEL maintainer="bbrassar@student.42.fr"

COPY script/run.sh /tmp/run.sh
COPY script/install.sh /tmp/install.sh

RUN apk -U upgrade && apk add --no-cache mariadb mariadb-client

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
