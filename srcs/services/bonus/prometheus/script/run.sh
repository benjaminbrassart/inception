#!/bin/sh

PROMETHEUS_OPT="
	--config.file=/etc/prometheus/prometheus.yml
"

# shellcheck disable=2086
exec prometheus $PROMETHEUS_OPT
