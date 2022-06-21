FROM alpine:edge

ARG PROMTAIL_NAME=promtail-linux-amd64
ARG PROMTAIL_VER=2.5.0
ARG PROMTAIL_URI=https://github.com/grafana/loki/releases/download/v${PROMTAIL_VER}/${PROMTAIL_NAME}.zip

RUN apk -U upgrade && apk add --no-cache libc6-compat curl unzip

WORKDIR /tmp
RUN \
	curl -OL ${PROMTAIL_URI} && \
	unzip ${PROMTAIL_NAME}.zip && \
	mv ${PROMTAIL_NAME} /usr/bin/promtail && \
	mkdir -p /etc/promtail

WORKDIR /
COPY conf/promtail.yml /etc/promtail/promtail.yml

ENTRYPOINT [ "promtail", "--config.file=/etc/promtail/promtail.yml" ]
