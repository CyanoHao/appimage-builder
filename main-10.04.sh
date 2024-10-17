#!/bin/bash

set -euxo pipefail

alias nproc="getconf _NPROCESSORS_ONLN"

_PATCHDIR=$PWD/patch
_BUILDDIR=$PWD/build/x86_64
_OLDPATH=$PATH

. module/bootstrap-toolchain.bash
. module/host-toolchain.bash
. module/host-qt.bash

function check_source() {
  if (
    [[ ! -f assets/binutils-2.35.2.tar.xz ]] || ! sha256sum -c checksum/binutils-2.35.2.tar.xz.sha256 ||
    [[ ! -f assets/cmake-3.30.5.tar.gz ]] || ! sha256sum -c checksum/cmake-3.30.5.tar.gz.sha256 ||
    [[ ! -f assets/gcc-9.5.0.tar.xz ]] || ! sha256sum -c checksum/gcc-9.5.0.tar.xz.sha256 ||
    [[ ! -f assets/gcc-14.2.0.tar.xz ]] || ! sha256sum -c checksum/gcc-14.2.0.tar.xz.sha256 ||
    [[ ! -f assets/gmp-6.3.0.tar.xz ]] || ! sha256sum -c checksum/gmp-6.3.0.tar.xz.sha256 ||
    [[ ! -f assets/mpc-1.3.1.tar.gz ]] || ! sha256sum -c checksum/mpc-1.3.1.tar.gz.sha256 ||
    [[ ! -f assets/mpfr-4.2.1.tar.xz ]] || ! sha256sum -c checksum/mpfr-4.2.1.tar.xz.sha256 ||
    [[ ! -f assets/ninja-1.12.1.tar.gz ]] || ! sha256sum -c checksum/ninja-1.12.1.tar.gz.sha256 ||
    [[ ! -f assets/Python-3.12.7.tar.xz ]] || ! sha256sum -c checksum/Python-3.12.7.tar.xz.sha256 ||
    [[ ! -f assets/qtbase-everywhere-src-6.8.0.tar.xz ]] || ! sha256sum -c checksum/qtbase-everywhere-src-6.8.0.tar.xz.sha256 ||
    [[ ! -f assets/qtsvg-everywhere-src-6.8.0.tar.xz ]] || ! sha256sum -c checksum/qtsvg-everywhere-src-6.8.0.tar.xz.sha256 ||
    [[ ! -f assets/qttools-everywhere-src-6.8.0.tar.xz ]] || ! sha256sum -c checksum/qttools-everywhere-src-6.8.0.tar.xz.sha256 ||
    [[ ! -f assets/qttranslations-everywhere-src-6.8.0.tar.xz ]] || ! sha256sum -c checksum/qttranslations-everywhere-src-6.8.0.tar.xz.sha256 ||
    [[ ! -f assets/qtwayland-everywhere-src-6.8.0.tar.xz ]] || ! sha256sum -c checksum/qtwayland-everywhere-src-6.8.0.tar.xz.sha256 ||
    [[ ! -f assets/zstd-1.5.6.tar.gz ]] || ! sha256sum -c checksum/zstd-1.5.6.tar.gz.sha256
  ); then
    echo "Ubuntu 10.04 is unable to download source code from internet."
    echo "Please run './fetch-10.04.sh' on host system."
    exit 1
  fi
}

function install_tools() {
  sed -i 's|archive.ubuntu.com|old-releases.ubuntu.com|' /etc/apt/sources.list
  apt-get update
  env DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
      $( true === build toolchain === ) \
      bison \
      build-essential \
      m4 \
      pkg-config \
      texinfo \
      $( true === qt deps === ) \
      libfontconfig1-dev \
      libfreetype6-dev \
      libx11-dev \
      libx11-xcb-dev \
      $( true === other deps === ) \
      git-core \
      zlib1g-dev \
      $( true === general === ) \
      ca-certificates \
      curl \
      xz-utils
}

check_source
install_tools
mkdir -p $_BUILDDIR

# build_bootstrap_binutils
# build_bootstrap_gmp
# build_bootstrap_mpfr
# build_bootstrap_mpc
# build_bootstrap_gcc
export PATH=/opt/bootstrap/bin:$_OLDPATH

# build_host_binutils
# build_host_gmp
# build_host_mpfr
# build_host_mpc
# build_host_gcc
export PATH=/opt/qt/bin:$_OLDPATH

# build_host_pkgconf
# build_host_zlib
# build_host_cmake
# build_host_ninja
# build_host_python
# build_host_meson
# build_host_zstd

# build_host_xorgproto
# build_host_xau
# build_host_xcb_proto
# build_host_xcb
# build_host_xcb_util
# build_host_xcb_util_image
# build_host_xcb_util_keysyms
# build_host_xcb_util_renderutil
# build_host_xcb_util_cursor
# build_host_xcb_util_wm
# build_host_xml
# build_host_xkbcommon
build_host_qtbase
