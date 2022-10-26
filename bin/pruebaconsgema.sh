#!/bin/sh
# Genera gema y la prueba en subdirectorio x

rm msip-*.gem
gem build
mkdir -p x
cd x
rm -rf *
tar xvf ../msip-*.gem
cp ../test/dummy/.env test/dummy/
bin/gc.sh

