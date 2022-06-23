#!/bin/sh

GRAFANA_OPT="
	-homepath /usr/share/grafana
"

# shellcheck disable=2086
exec grafana-server $GRAFANA_OPT
