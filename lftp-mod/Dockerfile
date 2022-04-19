ARG BUILD_FROM
FROM $BUILD_FROM

# Environment variables
ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements for add-on
RUN apk add --no-cache lftp

# Copy data
COPY rootfs /
RUN chmod a+x /run.sh

# Run the script
CMD [ "/run.sh" ]

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
