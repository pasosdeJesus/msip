#!/bin/sh
# Genera gema y la prueba en subdirectorio x

rm msip-*.gem
gem build
mkdir -p x
rm -rf x/*
cd x
tar xvf ../msip-*.gem
tar xvfz data.tar.gz
cp ../test/dummy/.env ./test/dummy/
bin/gc.sh

