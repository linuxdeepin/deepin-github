#!/bin/bash
set -x
sudo apt update
sudo apt -y install pbuilder
sudo install -Dvm644 mkpbuilder/etc/pbuilderrc /etc/pbuilderrc
sudo install -Dvm755 mkpbuilder/var/cache/pbuilder/hook.d/D10deepin-keyring /var/cache/pbuilder/hook.d/E10deepin-keyring
cat /etc/pbuilderrc
sudo pbuilder --create --distribution buster --basetgz ./pbuilder.tgz

