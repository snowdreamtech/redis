FROM snowdreamtech/alpine:3.20.2

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV REDIS_PORT=6379 \
    REDIS_PASS="" \
    DISALLOW_USER_LOGIN_REMOTELY=1

RUN apk add --no-cache redis=7.2.5-r0

COPY redis.conf /etc/redis.conf

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6379

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["redis-server", "/etc/redis.conf"]