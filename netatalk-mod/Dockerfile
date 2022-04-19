ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

RUN apk add --no-cache \
      netatalk

# Copy data
COPY rootfs /

EXPOSE 548

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
