#!/bin/sh
set -e

# Random REDIS_PASS Generator
if [ -z "${REDIS_PASS}" ]; then {
    REDIS_PASS=$(openssl rand -base64 33)
    echo "REDIS_PASS = ${REDIS_PASS}"
}
fi

# set REDIS_PORT
if [ -n "${REDIS_PORT}" ]; then
    sed -i "s|^port 6379|port ${REDIS_PORT}|g" "${REDIS_CONFIG_PATH}"
fi

# set REDIS_PASS
if [ -n "${REDIS_PASS}" ]; then
    sed -i "s|#*\s*requirepass\s*foobared|requirepass ${REDIS_PASS}|g" "${REDIS_CONFIG_PATH}"
fi

# set DISALLOW_USER_LOGIN_REMOTELY
if [ "${DISALLOW_USER_LOGIN_REMOTELY}" -eq 1 ]; then
    sed -i "s|^bind.*|bind 127.0.0.1 ::1|g" "${REDIS_CONFIG_PATH}"
else 
    sed -i "s|^bind.*|bind * -::*|g" "${REDIS_CONFIG_PATH}"
fi

# start redis 
/usr/bin/redis-server /etc/redis/redis.conf --daemonize yes

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null & wait
    # sleep infinity & wait
fi