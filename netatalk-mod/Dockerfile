# Build arguments
ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_VERSION
ARG NETATALK_VERSION

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache \
        netatalk>$NETATALK_VERSION \
        dbus \
        avahi \
        avahi-compat-libdns_sd \
        avahi-tools \
    && sed -i 's/#enable-dbus=.*/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

# Copy data
COPY rootfs /

EXPOSE 548

# Labels
LABEL \
  io.hass.name="Netatalk for ${BUILD_ARCH}" \
  io.hass.description="Home Assistant Add-on: ${BUILD_ARCH} Netatalk image" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="ElVit <https://github.com/ElVit>"
