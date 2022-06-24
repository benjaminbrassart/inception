FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache prometheus curl

COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

ENTRYPOINT [ "prometheus", "--config.file=/etc/prometheus/prometheus.yml" ]
