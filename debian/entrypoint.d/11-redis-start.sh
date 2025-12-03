#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [redis] Starting redis..."; fi

# start redis 
/usr/bin/redis-server /etc/redis/redis.conf --daemonize yes

if [ "$DEBUG" = "true" ]; then echo "→ [redis] Redis started."; fi
