#!/bin/bash

export GCC=${GCC:?Please set GCC variable to desired gcc major version}

mkdir -p ${PWD}/output/downloads
mkdir -p ${PWD}/output/gcc${GCC}

###############################################################################
#
# Build
#
###############################################################################
export CT_PREFIX="${PWD}/output/gcc${GCC}"
DEFCONFIG=configs/x86_64-unknown-linux-gnu_gcc${GCC} ct-ng defconfig
ct-ng -j$(nproc) build

###############################################################################
#
# Package
#
###############################################################################
function get_commit_time() {
  TZ=UTC0 git log -1 \
    --format=tformat:%cd \
    --date=format:%Y-%m-%dT%H:%M:%SZ
}

SOURCE_EPOCH=$get_commit_time

tar -c \
    --sort=name \
    --mtime="${SOURCE_EPOCH}" \
    --owner=0 \
    --group=0 \
    --numeric-owner \
    -C "output/gcc${GCC}" . \
    | gzip -n > "output/x86_64-unknown-linux-gnu_gcc${GCC}.tar.gz"
