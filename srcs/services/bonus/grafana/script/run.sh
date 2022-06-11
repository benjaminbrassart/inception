#!/bin/sh

GRAFANA_OPT="
	-homepath /usr/share/grafana
"

exec grafana-server $GRAFANA_OPT
