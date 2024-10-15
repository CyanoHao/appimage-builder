#!/bin/bash

set -euxo pipefail

apt update
env DEBIAN_FRONTEND=noninteractive \
  apt install -y --no-install-recommends \
    $( true === build tools === ) \
    bison \
    cmake \
    g++ \
    gcc \
    gperf \
    m4 \
    make \
    meson \
    pkgconf \
    python3 \
    texinfo \
    $( true === general utils === ) \
    bzip2 \
    ca-certificates \
    curl \
    patch \
    xz-utils \
    zstd \
    $( true === host libs === ) \
    libexpat1-dev \
    $( true === host qt tools === ) \
    qttools5-dev-tools

_ARCH=x86_64
while [[ $# -gt 0 ]]; do
  case $1 in
    -a|--arch)
      _ARCH=$2
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

case $_ARCH in
  x86_64)
    _KERNAL_ARCH=x86
    _TARGET=x86_64-linux-musl
    ;;
  aarch64)
    _KERNAL_ARCH=arm64
    _TARGET=aarch64-linux-musl
    ;;
  riscv64)
    _KERNAL_ARCH=riscv
    _TARGET=riscv64-linux-musl
    ;;
  i686)
    _KERNAL_ARCH=x86
    _TARGET=i686-linux-musl
    ;;
  *)
    echo "Unsupported architecture: $_ARCH"
    exit 1
    ;;
esac

_ROOTDIR=$PWD
_ASSETS=$PWD/assets
_PATCHDIR=$PWD/patch
_BUILDDIR=$PWD/build/$_TARGET
_PREFIX=/opt/qt-$_ARCH-musl
_CMAKE_CROSS=-DCMAKE_TOOLCHAIN_FILE=$_ROOTDIR/cmake/$_TARGET.cmake
_MESON_CROSS="--cross-file $_ROOTDIR/meson/$_TARGET.txt"

. module/host-lib.bash
. module/host-util.bash
. module/cross-toolchain.bash
. module/target-lib-a.bash
. module/target-lib-d.bash
. module/target-lib-e.bash
. module/target-lib-f.bash
. module/target-lib-g.bash
. module/target-lib-h.bash
. module/target-lib-j.bash
. module/target-lib-m.bash
. module/target-lib-p.bash
. module/target-lib-q.bash
. module/target-lib-s.bash
. module/target-lib-w.bash
. module/target-lib-x.bash
. module/target-lib-z.bash

mkdir -p assets "$_BUILDDIR"

pushd "$_BUILDDIR"
{
  build_host_gmp
  build_host_mpfr
  build_host_mpc

  build_host_wayland_scanner

  export PATH=$_PREFIX/bin:$PATH
  export PKG_CONFIG_LIBDIR=$_PREFIX/$_TARGET/lib/pkgconfig:$_PREFIX/$_TARGET/share/pkgconfig

  build_cross_linux_headers
  build_cross_binutils
  build_cross_gcc_p1
  build_target_musl_p1
  build_cross_gcc_p2
  build_target_musl_p2
  build_cross_gcc_p3

  build_target_double_conversion
  build_target_jpeg_turbo
  build_target_expat
  build_target_xml
  build_target_dbus
  build_target_zlib
  build_target_sqlite
  build_target_zstd
  build_target_pcre
  build_target_ffi
  build_target_glib
  build_target_xproto
  build_target_xau
  build_target_xcb_proto
  build_target_xcb
  build_target_xcb_util
  build_target_xcb_util_image
  build_target_xcb_util_keysyms
  build_target_xcb_util_renderutil
  build_target_xcb_util_wm
  build_target_xtrans
  build_target_x11
  build_target_xext
  build_target_xfixes
  build_target_xi
  build_target_xtst
  build_target_at_spi
  build_target_xkeyboard_config
  build_target_xkbcommon
  build_target_png
  build_target_freetype_decycle
  build_target_harfbuzz
  build_target_freetype
  build_target_fontconfig
  build_target_wayland

  build_target_qt
}
popd
