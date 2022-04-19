ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache \
      samba-common-tools \
      samba-server \
    \
    && mkdir -p /var/lib/samba \
    && touch \
      /etc/samba/lmhosts \
      /var/lib/samba/account_policy.tdb \
      /var/lib/samba/registry.tdb \
      /var/lib/samba/winbindd_idmap.tdb

# Copy data
COPY rootfs /

# Build arguments
ARG BUILD_NAME
ARG BUILD_DESCRIPTION
ARG BUILD_ARCH
ARG BUILD_VERSION

# Labels
LABEL \
  io.hass.name="${BUILD_NAME}" \
  io.hass.description="${BUILD_DESCRIPTION}" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="ElVit <https://github.com/ElVit>"