# Base Image (Alpine Variant)
# Extends snowdreamtech/alpine with additional tooling and configuration.

FROM snowdreamtech/alpine:3.24.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    REDIS_VERSION=8.8.0-r0

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-8.0.4}"
# x-release-please-end
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Redis Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Redis on Alpine. (386, amd64, arm/v6, arm/v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/redis" \
    org.opencontainers.image.base.name="snowdreamtech/alpine:3.24.0" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/redis" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/redis"

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    REDIS_VERSION=${REDIS_VERSION} \
    REDIS_CONFIG_PATH=/etc/redis/redis.conf \
    REDIS_PORT=6379 \
    REDIS_PASS="" \
    DISALLOW_USER_LOGIN_REMOTELY=1

# Additional tooling and configuration for Redis image
RUN apk update \
    && apk add --no-cache \
    redis=${REDIS_VERSION} \
    && mkdir -p /etc/redis \
    && [ -f /etc/redis.conf ] && mv /etc/redis.conf ${REDIS_CONFIG_PATH} || true

EXPOSE 6379

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
