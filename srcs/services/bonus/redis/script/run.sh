#!/bin/sh

# Options
#	--protected-mode no
#		do not restrict incoming connections to loopback address
#	--bind 0.0.0.0
#		allow every address to connect
#	--maxmemory-policy allkeys-lru
#		if max memory is reached, keep most recently used keys
#
# see https://redis.io/docs/manual/config/
# see https://redis.io/docs/manual/eviction/

REDIS_OPT="
    --protected-mode no
    --bind 0.0.0.0
    --maxmemory-policy allkeys-lru
    --maxmemory ${REDIS_MAX_MEMORY}
"

HUGEPAGE_CONF='/sys/kernel/mm/transparent_hugepage/enabled'
[ ! -f "${HUGEPAGE_CONF}" ] && echo never > "${HUGEPAGE_CONF}"

# enable memory overcommitting (because redis uses lots of memory)
sysctl vm.overcommit_memory=1

# shellcheck disable=2086
exec redis-server ${REDIS_OPT}
