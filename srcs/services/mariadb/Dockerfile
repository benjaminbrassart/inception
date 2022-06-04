FROM alpine:3.16

LABEL maintainer="bbrassar@student.42.fr"

COPY script/install.sh /tmp/install.sh

RUN apk -U upgrade
RUN apk add --no-cache mariadb

ENTRYPOINT [ "/tmp/install.sh" ]
