# Build arguments
ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_VERSION
ARG LFTP_VERSION

# Environment variables
ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements for add-on
RUN apk add --no-cache \
        lftp>${LFTP_VERSION}

# Copy data
COPY rootfs /
RUN chmod a+x /run.sh

# Run the script
CMD [ "/run.sh" ]

# Labels
LABEL \
  io.hass.name="LFTP for ${BUILD_ARCH}" \
  io.hass.description="Home Assistant Add-on: ${BUILD_ARCH} LFTP image" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="ElVit <https://github.com/ElVit>"
