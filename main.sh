#!/bin/bash

set -euxo pipefail

apt update
env DEBIAN_FRONTEND=noninteractive \
  apt install -y --no-install-recommends \
    bison gcc g++ m4 make meson pkgconf python3 texinfo \
    qttools5-dev-tools \
    ca-certificates curl xz-utils zstd

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
    _TARGET=x86_64-linux-musl
    ;;
  aarch64)
    _TARGET=aarch64-linux-musl
    ;;
  riscv64)
    _TARGET=riscv64-linux-musl
    ;;
  loongarch64)
    _TARGET=loongarch64-linux-musl
    ;;
  i686)
    _TARGET=i686-linux-musl
    ;;
  *)
    echo "Unsupported architecture: $_ARCH"
    exit 1
    ;;
esac

_ROOTDIR="$PWD"
_ASSSETS="$PWD/assets"
_BUILDDIR="$PWD/build/$_TARGET"
_PREFIX=/opt/qt-$_ARCH-musl
_MESON_CROSS="--cross-file $_ROOTDIR/meson/$_TARGET.txt"

export PATH=$_PREFIX/bin:$PATH
export PKG_CONFIG_LIBDIR=$_PREFIX/$_TARGET/lib/pkgconfig:$_PREFIX/$_TARGET/share/pkgconfig

. module/host-lib.bash
. module/cross-toolchain.bash
. module/target-lib.bash

mkdir -p assets "$_BUILDDIR"

pushd "$_BUILDDIR"
{
  build_host_gmp
  build_host_mpfr
  build_host_mpc

  build_cross_binutils
  build_cross_gcc_p1
  build_target_musl_p1
  build_cross_gcc_p2
  build_target_musl_p2
  build_cross_gcc_p3

  build_target_expat
  build_target_xml
  build_target_dbus
  build_target_xproto
  build_target_xau
  build_target_xcb_proto
  build_target_xcb
  build_target_xcb_util
  build_target_xcb_util_image
  build_target_xcb_util_keysyms
  build_target_xcb_util_renderutil
  build_target_xcb_util_wm
  build_target_xkeyboard_config
  build_target_xkbcommon

  build_target_qt
}
popd
