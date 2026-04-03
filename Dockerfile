# Pinned to act-22.04 while act-24.04 is still in beta.
ARG ACT_VERSION=act-22.04
ARG ACT_DIGEST=sha256:1124b21751b15ffd808956d2950f0f40c7b200b282618a7473b0bf37bfcbe7cf

FROM ghcr.io/catthehacker/ubuntu:${ACT_VERSION}@${ACT_DIGEST} AS build
# Injected by buildx for multi-platform builds.
ARG TARGETARCH
# Provided via build-args in CI and publish workflows.
ARG BUILDKIT_TAG
# Per-arch SHA-256 digests from upstream moby/buildkit release assets.
# Both are required — buildx shares build-args across platform builds.
ARG BUILDKIT_CHECKSUM_AMD64
ARG BUILDKIT_CHECKSUM_ARM64
RUN set -eu && \
    TARBALL="buildkit-${BUILDKIT_TAG}.linux-${TARGETARCH}.tar.gz" && \
    if [ "${TARGETARCH}" = "amd64" ]; then EXPECTED="${BUILDKIT_CHECKSUM_AMD64}"; \
    elif [ "${TARGETARCH}" = "arm64" ]; then EXPECTED="${BUILDKIT_CHECKSUM_ARM64}"; \
    else echo "Unsupported arch: ${TARGETARCH}" >&2; exit 1; fi && \
    wget -q "https://github.com/moby/buildkit/releases/download/${BUILDKIT_TAG}/${TARBALL}" && \
    echo "${EXPECTED}  ${TARBALL}" | sha256sum -c - && \
    mkdir /buildkit && \
    tar -C /buildkit -xzf "${TARBALL}"

# Final stage — copies only the buildctl binary into a clean image.
# TODO: Switch to the less privileged runner variant (runner-22.04) once the
# PersistentVolume privilege mismatch between act-runner and workflow pod is resolved.
FROM ghcr.io/catthehacker/ubuntu:${ACT_VERSION}@${ACT_DIGEST}
LABEL org.opencontainers.image.title="act-buildkit-runner"
LABEL org.opencontainers.image.description="An Ubuntu based act runner with integrated BuildKit"
LABEL org.opencontainers.image.licenses="MIT"
COPY --from=build /buildkit/bin/buildctl /usr/bin/buildctl
