#!/bin/bash
git clone -b master git://git.sv.gnu.org/emacs.git

cd emacs
git checkout emacs-25.3

sudo apt install autoconf

sudo apt install --no-install-recommends texinfo
sudo apt install libgtk-3-dev libxpm-dev libjpeg8-dev libgif-dev libtinfo-dev libsvgpp-dev libmagickwand-dev libacl1-dev libgnutls28-dev

./configure
make bootstrap
make check
sudo make install
