#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/redis

GITHUB_PROJECT=ghcr.io/snowdreamtech/redis

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
-t ${DOCKER_HUB_PROJECT}:latest \
-t ${DOCKER_HUB_PROJECT}:7.2.5 \
-t ${DOCKER_HUB_PROJECT}:7.2 \
-t ${DOCKER_HUB_PROJECT}:7 \
-t ${GITHUB_PROJECT}:latest \
-t ${GITHUB_PROJECT}:7.2.5 \
-t ${GITHUB_PROJECT}:7.2 \
-t ${GITHUB_PROJECT}:7 \
. \
--push
