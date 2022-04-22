# Build arguments
ARG BUILD_FROM
FROM $BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_VERSION
ARG RCLONE_VERSION

RUN if [ "${BUILD_ARCH}" == "aarch64" ]; then BUILD_ARCH=arm64; \
    elif [ "${BUILD_ARCH}" == "i386" ]; then BUILD_ARCH=386; \
    elif [ "${BUILD_ARCH}" == "armhf" ]; then BUILD_ARCH=arm-v7; \
    elif [ "${BUILD_ARCH}" == "armv7" ]; then BUILD_ARCH=arm-v7; \
    fi && \
    apk add --no-cache unzip findutils && \
    wget --quiet -O /tmp/rclone.zip https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-${BUILD_ARCH}.zip && \
    unzip /tmp/rclone.zip -d /tmp && \
    cp /tmp/rclone-v${RCLONE_VERSION}-linux-${BUILD_ARCH}/rclone /usr/bin/rclone && \
    chmod a+x /usr/bin/rclone && \
    rm -rf /tmp/*

# Copy data
COPY rootfs /
RUN chmod a+x /run.sh

# Run the script
CMD [ "/run.sh" ]

# Labels
LABEL \
  io.hass.name="Rclone for ${BUILD_ARCH}" \
  io.hass.description="Home Assistant Add-on: ${BUILD_ARCH} Rclone image" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="ElVit <https://github.com/ElVit>"
