FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache proftpd proftpd-utils
RUN mkdir -p /run/proftpd

COPY conf/proftpd.conf /etc/proftpd/proftpd.conf
COPY script/run.sh /tmp/run.sh

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
