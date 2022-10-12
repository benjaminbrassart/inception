FROM alpine:3.15.6

LABEL maintainer="bbrassar@student.42.fr"

RUN apk -U upgrade && apk add --no-cache grafana curl

COPY conf/defaults.ini /usr/share/grafana/conf/defaults.ini

ENTRYPOINT [ "grafana-server", "-homepath", "/usr/share/grafana" ]
