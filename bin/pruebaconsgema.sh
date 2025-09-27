#!/bin/sh
# Genera gema y la prueba en subdirectorio x

rm -f pkg/msip-*.gem
bundle exec rake build
mkdir -p x
rm -rf x/*
cd x
tar xvf ../pkg/msip-*.gem
tar xvfz data.tar.gz
cp ../test/dummy/.env ./test/dummy/
bin/gc.sh
cd ..
rm -rf x/*

