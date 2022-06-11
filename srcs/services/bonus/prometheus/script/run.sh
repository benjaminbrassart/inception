#!/bin/sh

PROMETHEUS_OPT="
	--config.file=/etc/prometheus/prometheus.yml
"

exec prometheus $PROMETHEUS_OPT
