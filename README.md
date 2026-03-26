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
      image: ghcr.io/omniproc/act-buildkit-runner:1.28.0
    steps: 
    - name: git checkout
      uses: https://github.com/actions/checkout@v4
```

# Development

## BuildKit Version

Update `BUILDKIT_VERSION` to change the bundled BuildKit version (e.g., `v0.28.1`).

## Releases

Runner versioning is entirely controlled by [conventional commits](https://www.conventionalcommits.org/) and [release-please](https://github.com/googleapis/release-please):

| Prefix                         | Description     | Version Bump          |
| ------------------------------ | --------------- | --------------------- |
| `feat:`                        | New feature     | Minor (1.0.0 → 1.1.0) |
| `fix:`                         | Bug fix         | Patch (1.0.0 → 1.0.1) |
| `feat!:` or `BREAKING CHANGE:` | Breaking change | Major (1.0.0 → 2.0.0) |
| `docs:`, `chore:`, `ci:`       | Non-user-facing | No release            |

After merging to main, release-please creates a PR with changelog updates. Merging that PR creates a git tag, which triggers the image build and push.

To update BuildKit without triggering a release, use a non-release prefix like `chore: update BUILDKIT_VERSION`.