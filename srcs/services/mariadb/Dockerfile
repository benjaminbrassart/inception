FROM alpine:3.16

COPY scripts/install.sh /tmp/install.sh

RUN apk -U upgrade
RUN apk add --no-cache mariadb

ENTRYPOINT [ "/tmp/install.sh" ]
