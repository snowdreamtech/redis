#!/bin/sh
set -e

REDIS_CONFIG_PATH=/etc/redis.conf

# set REDIS_PORT
if [ -n "${REDIS_PORT}" ]; then
    sed -i "s|^port 6379|port ${REDIS_PORT}|g" ${REDIS_CONFIG_PATH}
fi

# set REDIS_PASS
if [ -n "${REDIS_PASS}" ]; then
    sed -i "s|#*\s*requirepass\s*foobared|requirepass ${REDIS_PASS}|g" ${REDIS_CONFIG_PATH}
fi

# set DISALLOW_USER_LOGIN_REMOTELY
if [ "${DISALLOW_USER_LOGIN_REMOTELY}" == 1 ]; then
    sed -i "s|^bind.*|bind 127.0.0.1 ::1|g" ${REDIS_CONFIG_PATH}
else 
    sed -i "s|^bind.*|bind * -::*|g" ${REDIS_CONFIG_PATH}
fi


# exec commands
exec "$@"
