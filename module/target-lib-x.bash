function build_target_x11() {
  if [[ ! -d libX11-1.8.10 ]]; then
    if [[ ! -f $_ASSETS/libX11-1.8.10.tar.xz ]]; then
      curl -L -o $_ASSETS/libX11-1.8.10.tar.xz \
        https://xorg.freedesktop.org/releases/individual/lib/libX11-1.8.10.tar.xz
    fi
    tar xf $_ASSETS/libX11-1.8.10.tar.xz --no-same-owner
  fi
  mkdir -p libX11-1.8.10/build
  pushd libX11-1.8.10/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xau() {
  if [[ ! -d libXau-1.0.11 ]]; then
    if [[ ! -f $_ASSETS/libXau-1.0.11.tar.xz ]]; then
      curl -L -o $_ASSETS/libXau-1.0.11.tar.xz \
        https://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.11.tar.xz
    fi
    tar xf $_ASSETS/libXau-1.0.11.tar.xz --no-same-owner
  fi
  mkdir -p libXau-1.0.11/build
  pushd libXau-1.0.11/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb() {
  if [[ ! -d libxcb-1.17.0 ]]; then
    if [[ ! -f $_ASSETS/libxcb-1.17.0.tar.xz ]]; then
      curl -L -o $_ASSETS/libxcb-1.17.0.tar.xz \
        https://xcb.freedesktop.org/dist/libxcb-1.17.0.tar.xz
    fi
    tar xf $_ASSETS/libxcb-1.17.0.tar.xz --no-same-owner
  fi
  mkdir -p libxcb-1.17.0/build
  pushd libxcb-1.17.0/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_proto() {
  if [[ ! -d xcb-proto-1.17.0 ]]; then
    if [[ ! -f $_ASSETS/xcb-proto-1.17.0.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-proto-1.17.0.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-proto-1.17.0.tar.xz
    fi
    tar xf $_ASSETS/xcb-proto-1.17.0.tar.xz --no-same-owner
  fi
  mkdir -p xcb-proto-1.17.0/build
  pushd xcb-proto-1.17.0/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_util() {
  if [[ ! -d xcb-util-0.4.1 ]]; then
    if [[ ! -f $_ASSETS/xcb-util-0.4.1.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-util-0.4.1.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz
    fi
    tar xf $_ASSETS/xcb-util-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p xcb-util-0.4.1/build
  pushd xcb-util-0.4.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_util_image() {
  if [[ ! -d xcb-util-image-0.4.1 ]]; then
    if [[ ! -f $_ASSETS/xcb-util-image-0.4.1.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-util-image-0.4.1.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-util-image-0.4.1.tar.xz
    fi
    tar xf $_ASSETS/xcb-util-image-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p xcb-util-image-0.4.1/build
  pushd xcb-util-image-0.4.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_util_keysyms() {
  if [[ ! -d xcb-util-keysyms-0.4.1 ]]; then
    if [[ ! -f $_ASSETS/xcb-util-keysyms-0.4.1.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-util-keysyms-0.4.1.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.1.tar.xz
    fi
    tar xf $_ASSETS/xcb-util-keysyms-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p xcb-util-keysyms-0.4.1/build
  pushd xcb-util-keysyms-0.4.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_util_renderutil() {
  if [[ ! -d xcb-util-renderutil-0.3.10 ]]; then
    if [[ ! -f $_ASSETS/xcb-util-renderutil-0.3.10.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-util-renderutil-0.3.10.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.10.tar.xz
    fi
    tar xf $_ASSETS/xcb-util-renderutil-0.3.10.tar.xz --no-same-owner
  fi
  mkdir -p xcb-util-renderutil-0.3.10/build
  pushd xcb-util-renderutil-0.3.10/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_util_wm() {
  if [[ ! -d xcb-util-wm-0.4.2 ]]; then
    if [[ ! -f $_ASSETS/xcb-util-wm-0.4.2.tar.xz ]]; then
      curl -L -o $_ASSETS/xcb-util-wm-0.4.2.tar.xz \
        https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.2.tar.xz
    fi
    tar xf $_ASSETS/xcb-util-wm-0.4.2.tar.xz --no-same-owner
  fi
  mkdir -p xcb-util-wm-0.4.2/build
  pushd xcb-util-wm-0.4.2/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xext() {
  if [[ ! -d libXext-1.3.6 ]]; then
    if [[ ! -f $_ASSETS/libXext-1.3.6.tar.xz ]]; then
      curl -L -o $_ASSETS/libXext-1.3.6.tar.xz \
        https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.6.tar.xz
    fi
    tar xf $_ASSETS/libXext-1.3.6.tar.xz --no-same-owner
  fi
  mkdir -p libXext-1.3.6/build
  pushd libXext-1.3.6/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xfixes() {
  if [[ ! -d libXfixes-6.0.1 ]]; then
    if [[ ! -f $_ASSETS/libXfixes-6.0.1.tar.xz ]]; then
      curl -L -o $_ASSETS/libXfixes-6.0.1.tar.xz \
        https://xorg.freedesktop.org/archive/individual/lib/libXfixes-6.0.1.tar.xz
    fi
    tar xf $_ASSETS/libXfixes-6.0.1.tar.xz --no-same-owner
  fi
  mkdir -p libXfixes-6.0.1/build
  pushd libXfixes-6.0.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xi() {
  if [[ ! -d libXi-1.8.2 ]]; then
    if [[ ! -f $_ASSETS/libXi-1.8.2.tar.xz ]]; then
      curl -L -o $_ASSETS/libXi-1.8.2.tar.xz \
        https://xorg.freedesktop.org/archive/individual/lib/libXi-1.8.2.tar.xz
    fi
    tar xf $_ASSETS/libXi-1.8.2.tar.xz --no-same-owner
  fi
  mkdir -p libXi-1.8.2/build
  pushd libXi-1.8.2/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xkbcommon() {
  if [[ ! -d libxkbcommon-1.7.0 ]]; then
    if [[ ! -f $_ASSETS/libxkbcommon-1.7.0.tar.xz ]]; then
      curl -L -o $_ASSETS/libxkbcommon-1.7.0.tar.xz \
        https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz
    fi
    tar xf $_ASSETS/libxkbcommon-1.7.0.tar.xz --no-same-owner
  fi
  pushd libxkbcommon-1.7.0
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      -Denable-wayland=false \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}

function build_target_xkeyboard_config() {
  if [[ ! -d xkeyboard-config-2.43 ]]; then
    if [[ ! -f $_ASSETS/xkeyboard-config-2.43.tar.xz ]]; then
      curl -L -o $_ASSETS/xkeyboard-config-2.43.tar.xz \
        https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.43.tar.xz
    fi
    tar xf $_ASSETS/xkeyboard-config-2.43.tar.xz --no-same-owner
  fi
  pushd xkeyboard-config-2.43
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}

function build_target_xml() {
  if [[ ! -d libxml2-2.13.4 ]]; then
    if [[ ! -f $_ASSETS/libxml2-2.13.4.tar.xz ]]; then
      curl -L -o $_ASSETS/libxml2-2.13.4.tar.xz \
        https://download.gnome.org/sources/libxml2/2.13/libxml2-2.13.4.tar.xz
    fi
    tar xf $_ASSETS/libxml2-2.13.4.tar.xz --no-same-owner
  fi
  mkdir -p libxml2-2.13.4/build
  pushd libxml2-2.13.4/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      --without-python \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xproto() {
  if [[ ! -d xorgproto-2024.1 ]]; then
    if [[ ! -f $_ASSETS/xorgproto-2024.1.tar.xz ]]; then
      curl -L -o $_ASSETS/xorgproto-2024.1.tar.xz \
        https://xorg.freedesktop.org/releases/individual/proto/xorgproto-2024.1.tar.xz
    fi
    tar xf $_ASSETS/xorgproto-2024.1.tar.xz --no-same-owner
  fi
  mkdir -p xorgproto-2024.1/build
  pushd xorgproto-2024.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xtrans() {
  if [[ ! -d xtrans-1.5.0 ]]; then
    if [[ ! -f $_ASSETS/xtrans-1.5.0.tar.xz ]]; then
      curl -L -o $_ASSETS/xtrans-1.5.0.tar.xz \
        https://xorg.freedesktop.org/releases/individual/lib/xtrans-1.5.0.tar.xz
    fi
    tar xf $_ASSETS/xtrans-1.5.0.tar.xz --no-same-owner
  fi
  mkdir -p xtrans-1.5.0/build
  pushd xtrans-1.5.0/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xtst() {
  if [[ ! -d libXtst-1.2.5 ]]; then
    if [[ ! -f $_ASSETS/libXtst-1.2.5.tar.xz ]]; then
      curl -L -o $_ASSETS/libXtst-1.2.5.tar.xz \
        https://xorg.freedesktop.org/releases/individual/lib/libXtst-1.2.5.tar.xz
    fi
    tar xf $_ASSETS/libXtst-1.2.5.tar.xz --no-same-owner
  fi
  pushd libXtst-1.2.5
  {
    ./configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}
