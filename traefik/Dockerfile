ARG BUILD_FROM=ghcr.io/hassio-addons/base:17.2.1

FROM ${BUILD_FROM}

ARG NGINX_VERSION=1.26.3-r0
ARG TRAEFIK_VERSION=3.1.7-r5

RUN apk add --no-cache \
            nginx=${NGINX_VERSION} \
            traefik=${TRAEFIK_VERSION}

RUN mkdir -p /etc/traefik

# Copy local files
COPY rootfs/ /

# Corrects permissions for s6 v3
RUN if [ -d /etc/cont-init.d ]; then \
      chmod -R 755 /etc/cont-init.d; \
    fi && \
    if [ -d /etc/services.d ]; then \
      chmod -R 755 /etc/services.d; \
    fi && \
    if [ -d /etc/templates ]; then \
      chmod -R 755 /etc/templates; \
    fi && \
    if [ -d /etc/traefik ]; then \
      chmod -R 755 /etc/traefik; \
    fi

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="ElVit (https://github.com/ElVit)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="ElVit (https://github.com/ElVit)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/ElVit" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
