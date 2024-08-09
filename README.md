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
      image: ghcr.io/omniproc/act-buildkit-runner:0.1.1
    steps: 
    - name: git checkout
      uses: https://github.com/actions/checkout@v4
```