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
        netatalk \
        avahi \
        # avahi \
        # avahi-compat-libdns_sd \
        # avahi-tools \
        # dbus \
        # db \
        # tracker-miners \
    && sed -i 's/#enable-dbus=.*/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

# RUN apk add --no-cache git autoconf libtool automake pkgconfig db libgcrypt tracker avahi dbus \
#     && git clone git://git.code.sf.net/p/netatalk/code netatalk-code \
#     && cd netatalk \
#     && ./bootstrap

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
