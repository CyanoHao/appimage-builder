#!/bin/bash

set -euxo pipefail

mkdir -p assets
if [[ ! -f assets/binutils-2.35.2.tar.xz ]]; then
  # new enough to support LTO, and old enough to build with glibc in ~2010
  curl -L -o assets/binutils-2.35.2.tar.xz http://ftpmirror.gnu.org/binutils/binutils-2.35.2.tar.xz
fi
sha256sum -c checksum/binutils-2.35.2.tar.xz.sha256

if [[ ! -f assets/cmake-3.30.5.tar.gz ]]; then
  curl -L -o assets/cmake-3.30.5.tar.gz https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5.tar.gz
fi
sha256sum -c checksum/cmake-3.30.5.tar.gz.sha256

if [[ ! -f assets/gcc-9.5.0.tar.xz ]]; then
  curl -L -o assets/gcc-9.5.0.tar.xz http://ftpmirror.gnu.org/gcc/gcc-9.5.0/gcc-9.5.0.tar.xz
fi
sha256sum -c checksum/gcc-9.5.0.tar.xz.sha256

if [[ ! -f assets/gcc-14.2.0.tar.xz ]]; then
  curl -L -o assets/gcc-14.2.0.tar.xz http://ftpmirror.gnu.org/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz
fi
sha256sum -c checksum/gcc-14.2.0.tar.xz.sha256

if [[ ! -f assets/gmp-6.3.0.tar.xz ]]; then
  curl -L -o assets/gmp-6.3.0.tar.xz http://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
fi
sha256sum -c checksum/gmp-6.3.0.tar.xz.sha256

if [[ ! -f assets/meson-1.5.2.tar.gz ]]; then
  curl -L -o assets/meson-1.5.2.tar.gz https://github.com/mesonbuild/meson/releases/download/1.5.2/meson-1.5.2.tar.gz
fi
sha256sum -c checksum/meson-1.5.2.tar.gz.sha256

if [[ ! -f assets/mpc-1.3.1.tar.gz ]]; then
  curl -L -o assets/mpc-1.3.1.tar.gz http://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
fi
sha256sum -c checksum/mpc-1.3.1.tar.gz.sha256

if [[ ! -f assets/mpfr-4.2.1.tar.xz ]]; then
  curl -L -o assets/mpfr-4.2.1.tar.xz http://ftpmirror.gnu.org/mpfr/mpfr-4.2.1.tar.xz
fi
sha256sum -c checksum/mpfr-4.2.1.tar.xz.sha256

if [[ ! -f assets/ninja-1.12.1.tar.gz ]]; then
  curl -L -o assets/ninja-1.12.1.tar.gz https://github.com/ninja-build/ninja/archive/refs/tags/v1.12.1.tar.gz
fi
sha256sum -c checksum/ninja-1.12.1.tar.gz.sha256

if [[ ! -f assets/Python-3.13.0.tar.xz ]]; then
  curl -L -o assets/Python-3.13.0.tar.xz https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tar.xz
fi
sha256sum -c checksum/Python-3.13.0.tar.xz.sha256

for module in base svg tools translations; do
  if [[ ! -f assets/qt$module-everywhere-src-6.8.0.tar.xz ]]; then
    curl -L -o assets/qt$module-everywhere-src-6.8.0.tar.xz http://download.qt.io/archive/qt/6.8/6.8.0/submodules/qt$module-everywhere-src-6.8.0.tar.xz
  fi
  sha256sum -c checksum/qt$module-everywhere-src-6.8.0.tar.xz.sha256
done

if [[ ! -f assets/zstd-1.5.6.tar.gz ]]; then
  curl -L -o assets/zstd-1.5.6.tar.gz http://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz
fi
sha256sum -c checksum/zstd-1.5.6.tar.gz.sha256
