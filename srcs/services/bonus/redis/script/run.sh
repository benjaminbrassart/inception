#!/bin/sh

#	--protected-mode no
#		do not restrict incoming connections to loopback address
#	--bind 0.0.0.0
#		allow every address to connect
#	--maxmemory-policy allkeys-lru
#		if max memory is reached, keep most recently used keys
REDIS_OPT="
	--protected-mode no
	--bind 0.0.0.0
	--maxmemory-policy allkeys-lru
	--maxmemory $REDIS_MAX_MEMORY
"

HUGEPAGE_CONF='/sys/kernel/mm/transparent_hugepage/enabled'
[ ! -f "$HUGEPAGE_CONF" ] && echo never > $HUGEPAGE_CONF

sysctl vm.overcommit_memory=1

exec redis-server $REDIS_OPT
