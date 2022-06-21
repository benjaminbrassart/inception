FROM alpine:3.16

RUN apk -U upgrade && apk add --no-cache prometheus curl

COPY script/run.sh /tmp/run.sh
COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
