#!/bin/bash
set -x
repos=$(ls -d /app/repos/* | awk -F '/' '{print $NF}')

for m_repo in $repos; do
  case "$m_repo" in
  $1)
    export repo=$1
    break
    ;;
  *)
    export repo=deepin
    ;;
  esac
done
/app/common/scripts/prepare-pbuilder.sh
/app/common/scripts/change-version.sh
/app/common/scripts/build-package.sh
