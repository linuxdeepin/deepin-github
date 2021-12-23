#!/bin/bash
set -x
BUILD_DIR="/opt/cache/build"
dpkg-source -b ./
sudo /usr/sbin/pbuilder --update --no-targz --buildplace ${BUILD_DIR}
sudo DEB_BUILD_OPTIONS=nocheck /usr/sbin/pbuilder --build --no-targz --buildplace ${BUILD_DIR} --buildresult /opt/cache/build-result ../*.dsc
