# Deepin Pbuilder Docker Image

[简体中文](./README_zh.md)

## What is this

This is a docker image for build Debian package.

[![Publish Docker](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-docker.yml/badge.svg)](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-docker.yml)
[![Publish Pbuilder](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-pbuilder.yml/badge.svg)](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-pbuilder.yml)

## How to use this in Github Actions

create Github Action YAML file `.github/workflows/pr.yml`:

```yaml
on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/linuxdeepin/deepin-github:latest
      options: --privileged
    steps:
      - uses: actions/checkout@v2
      - run: /entrypoint.sh
```

Use deepin-community repository by default, we can use `/entrypoint.sh reponame` to special which repo used for compiling.

The currently maintainly repos could be found in [repos folder](./repos).

Multi-repos build Actions example:

```yaml
on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/linuxdeepin/deepin-github:latest
      options: --privileged
    strategy:
      matrix:
        repo: [deepin, buster]
    steps:
      - uses: actions/checkout@v2
      - run: /entrypoint.sh ${{ matrix.repo }}
```

## Why this image required `privileged`

Because we use [Pbuilder](https://pbuilder-team.pages.debian.net/pbuilder) to build package, Pbuilder need permission to mount something like `/proc` ...
