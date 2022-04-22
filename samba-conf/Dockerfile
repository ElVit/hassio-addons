# Build arguments
ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_VERSION
ARG SAMBA_VERSION

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache \
        samba-common-tools \
        samba-server \
    && mkdir -p /var/lib/samba \
    && touch \
        /etc/samba/lmhosts \
        /var/lib/samba/account_policy.tdb \
        /var/lib/samba/registry.tdb \
        /var/lib/samba/winbindd_idmap.tdb

# Copy data
COPY rootfs /

# Labels
LABEL \
  io.hass.name="Samba for ${BUILD_ARCH}" \
  io.hass.description="Home Assistant Add-on: ${BUILD_ARCH} Samba image" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="ElVit <https://github.com/ElVit>"
