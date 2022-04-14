ARG BUILD_FROM=alpine:3.14.2
# hadolint ignore=DL3006
FROM $BUILD_FROM

# Environment variables
ENV LANG C.UTF-8 \
  HOME /root \
  TERM xterm-256color

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements for add-on
RUN apk add --no-cache lftp

# Copy data for add-on
COPY run.sh /
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
