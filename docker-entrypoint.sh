#!/bin/sh
set -e

REDIS_CONFIG_PATH=/etc/redis.conf

# set REDIS_PORT
if [ -n "${REDIS_PORT}" ]; then
    sed -i "s|^port 6379|port ${REDIS_PORT}|g" ${REDIS_CONFIG_PATH}
fi

# set REDIS_PASS
if [ -n "${REDIS_PASS}" ]; then
    sed -i "s|# requirepass.*|requirepass ${REDIS_PASS}|g" ${REDIS_CONFIG_PATH}
fi

# exec commands
exec "$@"
