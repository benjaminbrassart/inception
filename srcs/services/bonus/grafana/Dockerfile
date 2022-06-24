FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache grafana curl

COPY conf/defaults.ini /usr/share/grafana/conf/defaults.ini

ENTRYPOINT [ "grafana-server", "-homepath", "/usr/share/grafana" ]
