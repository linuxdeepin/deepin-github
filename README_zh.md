# Deepin Pbuilder Docker 镜像

[English](README.md)

## 介绍

这是一个编译 Debian 包的 Docker 镜像

[![Publish Docker](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-docker.yml/badge.svg)](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-docker.yml)
[![Publish Pbuilder](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-pbuilder.yml/badge.svg)](https://github.com/linuxdeepin/deepin-github/actions/workflows/release-pbuilder.yml)

## 如何在Github Actions 里使用

编辑 `.github/workflows/pr.yml`:

``` yaml
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

默认使用Deepin 社区仓库编译,可以通过`/entrypoint.sh 仓库名`来指定使用哪个仓库来编译, 当前支持的仓库可以在 [repos 文件夹](./repos) 中看到


多仓库Actions 示例:

``` yaml
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




## 为什么这个镜像要求 `privileged` 权限

因为我们选择使用 [Pbuilder](https://pbuilder-team.pages.debian.net/pbuilder) 来编包, Pbuilder 需要一些权限来挂载 `/proc` 之类的目录
