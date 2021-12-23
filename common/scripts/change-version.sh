#!/bin/bash
set -x
short_hash=$(git log -n 1 --pretty=format:'%h')
tag=$(git describe --tags --long | awk -F "-$num-g$short_hash" '{print $1}') || echo
if [ $tag ]; then
  version=${tag}+g${short_hash}
else
  version=0.0.0+g${short_hash}
fi

if [[ $(echo $(cat debian/changelog | head -n 1 | awk -F '(' '{print $2}' | awk -F ')' '{print $1}') | grep :) ]]; then
  prefix=$(cat debian/changelog | head -n 1 | awk -F '(' '{print $2}' | awk -F ')' '{print $1}' | awk -F ':' '{print $1}')
fi

if [ ${prefix} ]; then
  version=${prefix}:${version}
fi

if [ -f debian/source/format ] && [[ $(grep quilt debian/source/format) ]]; then
  dch -M -bv "${version}-1" -D unstable "hash: ${short_hash}"
  git deborig --force HEAD
else
  dch -M -bv "${version}" -D unstable "hash: ${short_hash}"
fi
