#!/bin/bash

set -euxo pipefail

_BUILDDIR=$PWD/build/x86_64

function install_tools() {
  apt update
  env DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
      $( true === build toolchain === ) \
      build-essential \
      m4 \
      $( true === general === ) \
      ca-certificates \
      curl \
      xz-utils
}

function download_source() {
  mkdir -p assets
  if [[ ! -f assets/gcc-14.2.0.tar.xz ]]; then
    curl -L -o assets/gcc-14.2.0.tar.xz https://ftpmirror.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz
  fi
  if [[ ! -f assets/gmp-6.3.0.tar.xz ]]; then
    curl -L -o assets/gmp-6.3.0.tar.xz https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
  fi
  if [[ ! -f assets/mpc-1.3.1.tar.gz ]]; then
    curl -L -o assets/mpc-1.3.1.tar.gz https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
  fi
  if [[ ! -f assets/mpfr-4.2.1.tar.xz ]]; then
    curl -L -o assets/mpfr-4.2.1.tar.xz https://ftpmirror.gnu.org/mpfr/mpfr-4.2.1.tar.xz
  fi
  for module in base svg tools translations; do
    if [[ ! -f assets/qt$module-everywhere-src-6.8.0.tar.xz ]]; then
      curl -L -o assets/qt$module-everywhere-src-6.8.0.tar.xz https://download.qt.io/archive/qt/6.8/6.8.0/submodules/qt$module-everywhere-src-6.8.0.tar.xz
    fi
  done
  if [[ ! -f assets/zstd-1.5.6.tar.gz ]]; then
    curl -L -o assets/zstd-1.5.6.tar.gz https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz
  fi
}

function build_gcc() {
  if [[ ! -d $_BUILDDIR/gcc-14.2.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gcc-14.2.0.tar.xz
  fi
  pushd $_BUILDDIR/gcc-14.2.0
  {
    ./configure \
      --prefix=/usr/local \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      $( true === features === ) \
      --disable-bootstrap \
      --enable-host-pie \
      --enable-languages=c,c++ \
      --disable-libsanitizer \
      --enable-lto \
      --disable-multilib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s \
      CFLAGS_FOR_TARGET=-O2 CXXFLAGS_FOR_TARGET=-O2 LDFLAGS_FOR_TARGET=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_gmp() {
  if [[ ! -d $_BUILDDIR/gmp-6.3.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gmp-6.3.0.tar.xz
  fi
  pushd $_BUILDDIR/gmp-6.3.0
  {
    ./configure \
      --prefix /usr/local \
      --enable-static \
      --disable-shared \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_mpc() {
  if [[ ! -d $_BUILDDIR/mpc-1.3.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpc-1.3.1.tar.gz
  fi
  pushd $_BUILDDIR/mpc-1.3.1
  {
    ./configure \
      --prefix /usr/local \
      --enable-static \
      --disable-shared \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_mpfr() {
  if [[ ! -d $_BUILDDIR/mpfr-4.2.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpfr-4.2.1.tar.xz
  fi
  pushd $_BUILDDIR/mpfr-4.2.1
  {
    ./configure \
      --prefix /usr/local \
      --enable-static \
      --disable-shared \
      --with-gmp=/usr/local \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_zstd() {
  if [[ ! -d $_BUILDDIR/zstd-1.5.6 ]]; then
    tar -C $_BUILDDIR -xf assets/zstd-1.5.6.tar.gz
  fi
  pushd $_BUILDDIR/zstd-1.5.6/build/meson
  {
    meson setup \
      --prefix /usr/local \
      --default-library static \
      --prefer-static \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}

install_tools
download_source

mkdir -p $_BUILDDIR
build_gmp
build_mpfr
build_mpc
build_gcc
