FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache grafana

COPY conf/defaults.ini /usr/share/grafana/conf/defaults.ini
COPY script/run.sh /tmp/run.sh

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
