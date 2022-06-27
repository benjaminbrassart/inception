FROM alpine:edge

LABEL maintainer="bbrassar@student.42.fr"

ARG LOKI_NAME=loki-linux-amd64
ARG LOKI_VER=2.5.0
ARG LOKI_URI=https://github.com/grafana/loki/releases/download/v${LOKI_VER}/${LOKI_NAME}.zip

RUN apk -U upgrade && apk add --no-cache curl unzip

WORKDIR /tmp
RUN \
	curl -OL ${LOKI_URI} && \
	unzip ${LOKI_NAME}.zip && \
	mv ${LOKI_NAME} /usr/bin/loki && \
	mkdir -p /etc/loki

WORKDIR /
COPY conf/loki.yml /etc/loki/loki.yml

ENTRYPOINT [ "loki", "--config.file=/etc/loki/loki.yml" ]
