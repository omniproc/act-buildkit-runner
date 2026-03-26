# Act BuildKit Runner

A [`act`](https://github.com/nektos/act) runner based on [`catthehacker/ubuntu:act-22.04`](https://github.com/catthehacker/docker_images) with integrated [buildkit](https://github.com/moby/buildkit). Foundation for [buildkit-build-push-action](https://github.com/omniproc/buildkit-build-push-action).


# Example usage

```yaml
name: Example
on:
  push
jobs:
  test:
    runs-on: ubuntu-22.04
    container:
      image: ghcr.io/omniproc/act-buildkit-runner:0.28.1
    steps: 
    - name: git checkout
      uses: actions/checkout@v6
```

# Development

## BuildKit Version

Update `BUILDKIT_VERSION` to change the bundled BuildKit version (e.g., `v0.28.1`).

## Releases

Runner versions match BuildKit versions exactly. When `BUILDKIT_VERSION` is updated on main, a new release is automatically created with the same version tag.

For example:
- `BUILDKIT_VERSION` = `v0.28.1` → Runner release `v0.28.1`
- `BUILDKIT_VERSION` = `v0.29.0` → Runner release `v0.29.0`

See [.github/workflows/README.md](.github/workflows/README.md) for workflow details.