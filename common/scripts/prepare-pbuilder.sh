#!/bin/bash
set -x
BUILD_DIR="/opt/cache/build"
sudo mkdir -p ${BUILD_DIR}
wget -q https://github.com/linuxdeepin/deepin-github/releases/latest/download/pbuilder.tgz -O /opt/cache/pbuilder.tgz
sudo mkdir -p ${BUILD_DIR}
sudo tar xf /opt/cache/pbuilder.tgz -C ${BUILD_DIR}
sudo rm -rfv ${BUILD_DIR}/proc
sudo cp /app/common/in_pbuilder/* ${BUILD_DIR}/ -rv
sudo cp /app/repos/${repo}/in_pbuilder/* ${BUILD_DIR}/ -rv
cat ${BUILD_DIR}/etc/apt/sources.list
