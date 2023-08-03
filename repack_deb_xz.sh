#!/bin/bash
orig_deb=$1
repacked=${orig_deb%.deb}_repacked.deb
mkdir -p repack
cd repack
ar x ../${orig_deb}
zstd -v -d < control.tar.zst | xz -v --threads=0 > control.tar.xz
zstd -v -d < data.tar.zst | xz -v --threads=0 > data.tar.xz
ar -m -c -a sdsd ../${repacked} debian-binary control.tar.xz data.tar.xz
cd ..
rm -rf repack

