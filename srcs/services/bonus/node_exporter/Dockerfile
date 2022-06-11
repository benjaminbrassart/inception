FROM alpine:3.16

ENV NODE_EXPORTER_VER=1.3.1
ENV NODE_EXPORTER_URL=https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VER}/node_exporter-${NODE_EXPORTER_VER}.linux-amd64.tar.gz

RUN apk -U upgrade && apk add --no-cache curl prometheus-node-exporter

WORKDIR /tmp

RUN curl -s -L ${NODE_EXPORTER_URL} -o - | \
	tar xzfO - node_exporter-${NODE_EXPORTER_VER}.linux-amd64/node_exporter > \
	/usr/bin/node_exporter && chmod +x /usr/bin/node_exporter

WORKDIR /

ENTRYPOINT [ "node_exporter", "--path.rootfs=/rootfs" ]
