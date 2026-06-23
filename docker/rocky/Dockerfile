# Base Image (Rocky Variant)
# Extends snowdreamtech/rocky with additional tooling and configuration.

FROM snowdreamtech/rocky:10.2.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=1 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root

# x-release-please-start-version
ARG REDIS_VERSION=8.0.4
# x-release-please-end
# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
# x-release-please-start-version
LABEL org.opencontainers.image.version="${VERSION:-8.0.4}"
# x-release-please-end
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Redis Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for Redis on Rocky. (amd64, arm64, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/redis" \
    org.opencontainers.image.base.name="snowdreamtech/rocky:10.2.0" \
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
RUN set -eux \
    && dnf -y --allowerasing update \
    && dnf -y --allowerasing install \
    valkey-${REDIS_VERSION} \
    && ln -sf /usr/bin/valkey-server /usr/bin/redis-server \
    && ln -sf /usr/bin/valkey-cli /usr/bin/redis-cli \
    && mkdir -p /etc/redis \
    && [ -f /etc/valkey/valkey.conf ] && mv /etc/valkey/valkey.conf ${REDIS_CONFIG_PATH} || true \
    && [ -f /etc/valkey.conf ] && mv /etc/valkey.conf ${REDIS_CONFIG_PATH} || true \
    && [ -f /etc/redis.conf ] && mv /etc/redis.conf ${REDIS_CONFIG_PATH} || true \
    && dnf -y --allowerasing autoremove \
    && dnf -y --allowerasing clean all \
    && rm -rf /var/cache/dnf \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

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
CMD ["/bin/bash"]
