#!/bin/bash

function install_tools() {
  apt update
  env DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    $( true === build toolchain === ) \
    build-essential \
    cmake \
    ninja-build \
    $( true === general === ) \
    ca-certificates \
    curl \
    xz-utils
}

function prepare_source() {
  mkdir -p assets
  for module in base svg tools translations; do
    if [[ ! -f assets/qt$module-everywhere-src-6.8.0.tar.xz ]]; then
      curl -L -o assets/qt$module-everywhere-src-6.8.0.tar.xz $QT_MIRROR/archive/qt/6.8/6.8.0/submodules/qt$module-everywhere-src-6.8.0.tar.xz
    fi
  done
}

install_tools
prepare_source
