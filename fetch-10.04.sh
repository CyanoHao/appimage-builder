#!/bin/bash

set -euxo pipefail

mkdir -p assets
if [[ ! -f assets/binutils-2.35.2.tar.xz ]]; then
  # >= 2.35 (gcc lto -> binutils)
  # < ? (binutils -> glibc)
  curl -L -o assets/binutils-2.35.2.tar.xz http://ftpmirror.gnu.org/binutils/binutils-2.35.2.tar.xz
fi
sha256sum -c checksum/binutils-2.35.2.tar.xz.sha256

if [[ ! -f assets/cmake-3.30.5.tar.gz ]]; then
  curl -L -o assets/cmake-3.30.5.tar.gz https://github.com/Kitware/CMake/releases/download/v3.30.5/cmake-3.30.5.tar.gz
fi
sha256sum -c checksum/cmake-3.30.5.tar.gz.sha256

if [[ ! -f assets/gcc-9.5.0.tar.xz ]]; then
  # >= ? (host gcc pie -> bootstrap gcc)
  # < 10 (bootstrap gcc -> system gcc)
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

if [[ ! -f assets/libXau-1.0.11.tar.xz ]]; then
  curl -L -o assets/libXau-1.0.11.tar.xz https://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.11.tar.xz
fi
sha256sum -c checksum/libXau-1.0.11.tar.xz.sha256

if [[ ! -f assets/libxcb-1.17.0.tar.xz ]]; then
  curl -L -o assets/libxcb-1.17.0.tar.xz https://xcb.freedesktop.org/dist/libxcb-1.17.0.tar.xz
fi
sha256sum -c checksum/libxcb-1.17.0.tar.xz.sha256

if [[ ! -f assets/libxkbcommon-1.7.0.tar.xz ]]; then
  curl -L -o assets/libxkbcommon-1.7.0.tar.xz https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz
fi
sha256sum -c checksum/libxkbcommon-1.7.0.tar.xz.sha256

if [[ ! -f assets/libxml2-2.13.4.tar.xz ]]; then
  curl -L -o assets/libxml2-2.13.4.tar.xz https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.4.tar.xz
fi
sha256sum -c checksum/libxml2-2.13.4.tar.xz.sha256

if [[ ! -f assets/meson-1.5.2-py3-none-any.whl ]]; then
  curl -L -o assets/meson-1.5.2-py3-none-any.whl https://files.pythonhosted.org/packages/55/a6/47b9353c331318a13eb050887eacfd61eb075746285f9baf7ef7de6ae235/meson-1.5.2-py3-none-any.whl
fi
sha256sum -c checksum/meson-1.5.2-py3-none-any.whl.sha256

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

if [[ ! -f assets/pkgconf-2.3.0.tar.xz ]]; then
  curl -L -o assets/pkgconf-2.3.0.tar.xz https://distfiles.ariadne.space/pkgconf/pkgconf-2.3.0.tar.xz
fi
sha256sum -c checksum/pkgconf-2.3.0.tar.xz.sha256

if [[ ! -f assets/Python-3.12.7.tar.xz ]]; then
  # >= 3.7 (meson -> python)
  # < 3.13 (python -> glibc)
  curl -L -o assets/Python-3.12.7.tar.xz https://www.python.org/ftp/python/3.12.7/Python-3.12.7.tar.xz
fi
sha256sum -c checksum/Python-3.12.7.tar.xz.sha256

for module in base svg tools translations wayland; do
  if [[ ! -f assets/qt$module-everywhere-src-6.8.0.tar.xz ]]; then
    curl -L -o assets/qt$module-everywhere-src-6.8.0.tar.xz http://download.qt.io/archive/qt/6.8/6.8.0/submodules/qt$module-everywhere-src-6.8.0.tar.xz
  fi
  sha256sum -c checksum/qt$module-everywhere-src-6.8.0.tar.xz.sha256
done

if [[ ! -f assets/xcb-util-0.4.1.tar.xz ]]; then
  curl -L -o assets/xcb-util-0.4.1.tar.xz https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz
fi
sha256sum -c checksum/xcb-util-0.4.1.tar.xz.sha256

if [[ ! -f assets/xcb-util-cursor-0.1.5.tar.xz ]]; then
  curl -L -o assets/xcb-util-cursor-0.1.5.tar.xz https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.5.tar.xz
fi
sha256sum -c checksum/xcb-util-cursor-0.1.5.tar.xz.sha256

if [[ ! -f assets/xcb-util-image-0.4.1.tar.xz ]]; then
  curl -L -o assets/xcb-util-image-0.4.1.tar.xz https://xcb.freedesktop.org/dist/xcb-util-image-0.4.1.tar.xz
fi
sha256sum -c checksum/xcb-util-image-0.4.1.tar.xz.sha256

if [[ ! -f assets/xcb-util-keysyms-0.4.1.tar.xz ]]; then
  curl -L -o assets/xcb-util-keysyms-0.4.1.tar.xz https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.1.tar.xz
fi
sha256sum -c checksum/xcb-util-keysyms-0.4.1.tar.xz.sha256

if [[ ! -f assets/xcb-util-renderutil-0.3.10.tar.xz ]]; then
  curl -L -o assets/xcb-util-renderutil-0.3.10.tar.xz https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.10.tar.xz
fi
sha256sum -c checksum/xcb-util-renderutil-0.3.10.tar.xz.sha256

if [[ ! -f assets/xcb-util-wm-0.4.2.tar.xz ]]; then
  curl -L -o assets/xcb-util-wm-0.4.2.tar.xz https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.2.tar.xz
fi
sha256sum -c checksum/xcb-util-wm-0.4.2.tar.xz.sha256

if [[ ! -f assets/xorgproto-2024.1.tar.xz ]]; then
  curl -L -o assets/xorgproto-2024.1.tar.xz https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2024.1.tar.xz
fi
sha256sum -c checksum/xorgproto-2024.1.tar.xz.sha256

if [[ ! -f assets/zlib-1.3.1.tar.xz ]]; then
  curl -L -o assets/zlib-1.3.1.tar.xz https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.xz
fi
sha256sum -c checksum/zlib-1.3.1.tar.xz.sha256

if [[ ! -f assets/zstd-1.5.6.tar.gz ]]; then
  curl -L -o assets/zstd-1.5.6.tar.gz http://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz
fi
sha256sum -c checksum/zstd-1.5.6.tar.gz.sha256
