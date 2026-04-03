# Act BuildKit Runner

An [`act`](https://github.com/nektos/act) runner based on [`catthehacker/ubuntu:act-22.04`](https://github.com/catthehacker/docker_images) with integrated [BuildKit](https://github.com/moby/buildkit). Foundation for [buildkit-build-push-action](https://github.com/omniproc/buildkit-build-push-action).

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

## Releases

Runner versions match BuildKit versions exactly. New BuildKit releases (above v0.28.0) are detected daily and automatically released, built, and published as multi-arch Docker images (`linux/amd64`, `linux/arm64`).

For example:

- BuildKit `v0.28.1` → Runner release `v0.28.1` → Image `ghcr.io/omniproc/act-buildkit-runner:0.28.1`
- BuildKit `v0.29.0` → Runner release `v0.29.0` → Image `ghcr.io/omniproc/act-buildkit-runner:0.29.0`

The pipeline is a `workflow_call` chain: **Update** → **Release** → **Publish**. See [.github/workflows/README.md](.github/workflows/README.md) for details.
