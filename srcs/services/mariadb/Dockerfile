FROM alpine:3.16

COPY script/install.sh /tmp/install.sh

RUN apk -U upgrade
RUN apk add --no-cache mariadb

ENTRYPOINT [ "/tmp/install.sh" ]
