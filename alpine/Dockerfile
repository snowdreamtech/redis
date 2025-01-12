FROM snowdreamtech/alpine:3.21.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Redis Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Redis on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/redis" \
    org.opencontainers.image.base.name="snowdreamtech/redis:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/redis" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="7.2.7" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/redis"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 

ENV REDIS_VERSION=7.2.7-r0 \
    REDIS_CONFIG_PATH=/etc/redis/redis.conf \
    REDIS_PORT=6379 \
    REDIS_PASS="" \
    DISALLOW_USER_LOGIN_REMOTELY=1

ARG GID=1000 \
    UID=1000  \
    USER=redis \
    WORKDIR=/var/lib/redis

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /sbin/nologin -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

RUN apk add --no-cache \
    redis=${REDIS_VERSION} \
    && mkdir -p /etc/redis \
    && mv /etc/redis.conf /etc/redis \
    && find / -name "*redis*" -exec chown -Rv ${USER}:${USER} {} \; 

# Switch to the user
USER ${USER}

# Set the workdir
WORKDIR ${WORKDIR}

EXPOSE 6379

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]