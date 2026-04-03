# Act BuildKit Runner

An [`act`](https://github.com/nektos/act) runner based on [`catthehacker/ubuntu:runner-22.04`](https://github.com/catthehacker/docker_images) with integrated [BuildKit](https://github.com/moby/buildkit). Foundation for [buildkit-build-push-action](https://github.com/omniproc/buildkit-build-push-action).

The image runs as non-root user `runner` (uid 1001) for improved security.

## Example usage

```yaml
name: Example
on:
  push:
    branches:
      - main
jobs:
  test:
    runs-on: ubuntu-24.04
    container:
      image: ghcr.io/omniproc/act-buildkit-runner:0.29.0
    steps: 
    - name: git checkout
      uses: actions/checkout@v6
```

### Kubernetes

This image runs as non-root user `runner` (uid 1001). On Kubernetes, PersistentVolumes shared between the act-runner controller and workflow pods are typically owned by root, which causes `Permission denied` errors.

To fix this, set `fsGroup` on the workflow pod's security context so the kubelet chowns the mounted volume:

```yaml
apiVersion: v1
kind: Pod
spec:
  securityContext:
    fsGroup: 1001
  containers:
    - name: runner
      image: ghcr.io/omniproc/act-buildkit-runner:0.29.0
```

## Releases

Runner versions match BuildKit versions exactly. New BuildKit releases (above v0.28.0) are detected daily and automatically released, built, and published as multi-arch Docker images (`linux/amd64`, `linux/arm64`).

For example:

- BuildKit `v0.28.1` → Runner release `v0.28.1` → Image `ghcr.io/omniproc/act-buildkit-runner:0.28.1`
- BuildKit `v0.29.0` → Runner release `v0.29.0` → Image `ghcr.io/omniproc/act-buildkit-runner:0.29.0`

The pipeline is a `workflow_call` chain: **Update** → **Release** → **Publish**. See [.github/workflows/README.md](.github/workflows/README.md) for details.
