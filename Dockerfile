FROM ghcr.io/catthehacker/ubuntu:act-22.04 AS build
# injected by build-push-action by default
ARG TARGETARCH
# injected by build-push-action build-args
ARG BUILDKIT_TAG
RUN echo "TARGETARCH=${TARGETARCH}"
RUN echo "BUILDKIT_TAG=${BUILDKIT_TAG}"
RUN wget -q "https://github.com/moby/buildkit/releases/download/${BUILDKIT_TAG}/buildkit-${BUILDKIT_TAG}.linux-${TARGETARCH}.tar.gz"
RUN mkdir /buildkit && cat buildkit-${BUILDKIT_TAG}.linux-${TARGETARCH}.tar.gz | tar -C /buildkit -zxvf -
# cleanup layers
# PersistentVolume privilege missmatch between act-runner and workflow pod currently stop us from using the less privileged runner variant
#FROM ghcr.io/catthehacker/ubuntu:runner-22.04
FROM ghcr.io/catthehacker/ubuntu:act-22.04
LABEL org.opencontainers.image.title act-buildkit-runner
LABEL org.opencontainers.image.description A Ubuntu based act runner with integrated buildkit
LABEL org.opencontainers.image.licenses MIT
COPY --from=build /buildkit/bin/buildctl /usr/bin/buildctl