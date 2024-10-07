function build_target_musl_p1() {
  if [[ ! -d musl-1.2.5 ]]; then
    if [[ ! -f "$_ASSSETS/musl-1.2.5.tar.gz" ]]; then
      curl -L -o "$_ASSSETS/musl-1.2.5.tar.gz" \
        https://musl.libc.org/releases/musl-1.2.5.tar.gz
    fi
    tar xf "$_ASSSETS/musl-1.2.5.tar.gz" --no-same-owner
  fi
  mkdir -p musl-1.2.5/build
  pushd musl-1.2.5/build
  {
    ../configure \
      --target=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make install-headers
  }
  popd
}

function build_target_musl_p2() {
  pushd musl-1.2.5/build
  {
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_expat() {
  if [[ ! -d expat-2.6.3 ]]; then
    if [[ ! -f "$_ASSSETS/expat-2.6.3.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/expat-2.6.3.tar.xz" \
        https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
    fi
    tar xf "$_ASSSETS/expat-2.6.3.tar.xz" --no-same-owner
  fi
  mkdir -p expat-2.6.3/build
  pushd expat-2.6.3/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_dbus() {
  if [[ ! -d dbus-1.14.10 ]]; then
    if [[ ! -f "$_ASSSETS/dbus-1.14.10.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/dbus-1.14.10.tar.xz" \
        https://dbus.freedesktop.org/releases/dbus/dbus-1.14.10.tar.xz
    fi
    tar xf "$_ASSSETS/dbus-1.14.10.tar.xz" --no-same-owner
  fi
  mkdir -p dbus-1.14.10/build
  pushd dbus-1.14.10/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xproto() {
  if [[ ! -d xorgproto-2024.1 ]]; then
    if [[ ! -f "$_ASSSETS/xorgproto-2024.1.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/xorgproto-2024.1.tar.xz" \
        https://xorg.freedesktop.org/releases/individual/proto/xorgproto-2024.1.tar.xz
    fi
    tar xf "$_ASSSETS/xorgproto-2024.1.tar.xz" --no-same-owner
  fi
  mkdir -p xorgproto-2024.1/build
  pushd xorgproto-2024.1/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xau() {
  if [[ ! -d libXau-1.0.11 ]]; then
    if [[ ! -f "$_ASSSETS/libXau-1.0.11.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/libXau-1.0.11.tar.xz" \
        https://xorg.freedesktop.org/releases/individual/lib/libXau-1.0.11.tar.xz
    fi
    tar xf "$_ASSSETS/libXau-1.0.11.tar.xz" --no-same-owner
  fi
  mkdir -p libXau-1.0.11/build
  pushd libXau-1.0.11/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb_proto() {
  if [[ ! -d xcb-proto-1.17.0 ]]; then
    if [[ ! -f "$_ASSSETS/xcb-proto-1.17.0.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/xcb-proto-1.17.0.tar.xz" \
        https://xcb.freedesktop.org/dist/xcb-proto-1.17.0.tar.xz
    fi
    tar xf "$_ASSSETS/xcb-proto-1.17.0.tar.xz" --no-same-owner
  fi
  mkdir -p xcb-proto-1.17.0/build
  pushd xcb-proto-1.17.0/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xcb() {
  if [[ ! -d libxcb-1.17.0 ]]; then
    if [[ ! -f "$_ASSSETS/libxcb-1.17.0.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/libxcb-1.17.0.tar.xz" \
        https://xcb.freedesktop.org/dist/libxcb-1.17.0.tar.xz
    fi
    tar xf "$_ASSSETS/libxcb-1.17.0.tar.xz" --no-same-owner
  fi
  mkdir -p libxcb-1.17.0/build
  pushd libxcb-1.17.0/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS="-O2" CXXFLAGS="-O2" LDFLAGS="-s"
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_xkeyboard_config() {
  if [[ ! -d xkeyboard-config-2.43 ]]; then
    if [[ ! -f "$_ASSSETS/xkeyboard-config-2.43.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/xkeyboard-config-2.43.tar.xz" \
        https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.43.tar.xz
    fi
    tar xf "$_ASSSETS/xkeyboard-config-2.43.tar.xz" --no-same-owner
  fi
  pushd xkeyboard-config-2.43
  {
    meson --prefix $_PREFIX/$_TARGET $_MESON_CROSS build
    meson compile -C build
    meson install -C build
  }
  popd
}

function build_target_xkbcommon() {
  if [[ ! -d libxkbcommon-1.7.0 ]]; then
    if [[ ! -f "$_ASSSETS/libxkbcommon-1.7.0.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/libxkbcommon-1.7.0.tar.xz" \
        https://xkbcommon.org/download/libxkbcommon-1.7.0.tar.xz
    fi
    tar xf "$_ASSSETS/libxkbcommon-1.7.0.tar.xz" --no-same-owner
  fi
  pushd libxkbcommon-1.7.0
  {
    meson --prefix $_PREFIX/$_TARGET $_MESON_CROSS build
    meson compile -C build
    meson install -C build
  }
  popd
}

function build_target_qt() {
  if [[ ! -d qt-everywhere-src-5.15.15 ]]; then
    if [[ ! -f "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" ]]; then
      curl -L -o "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" \
        https://download.qt.io/archive/qt/5.15/5.15.15/single/qt-everywhere-opensource-src-5.15.15.tar.xz
    fi
    tar xf "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" --no-same-owner
    pushd qt-everywhere-src-5.15.15
    {
      ls | grep ^qt | grep -vE 'qt(\.pro|base|svg|translations|wayland)' | xargs rm -r
    }
    popd
  fi
  if [[ ! -L $_PREFIX/bin/lrelease ]]; then
    ln -s /usr/bin/lrelease $_PREFIX/bin/lrelease
  fi
  mkdir -p qt-everywhere-src-5.15.15/build
  pushd qt-everywhere-src-5.15.15/build
  {
    ../configure -recheck-all \
      -prefix $_PREFIX/$_TARGET \
      -hostprefix $_PREFIX \
      $( true build option ) \
      -opensource \
      -confirm-license \
      -release \
      -static \
      -platform linux-g++ \
      -xplatform linux-g++ \
      -device-option CROSS_COMPILE=$_TARGET- \
      -ltcg \
      -linker gold \
      $( true build environment ) \
      -sysroot / \
      -no-gcc-sysroot \
      -pkg-config \
      $( true component selection ) \
      -nomake examples \
      -nomake tests \
      -nomake tools \
      -dbus-linked \
      $( true core option ) \
      -qt-doubleconversion \
      -no-glib \
      -eventfd \
      -inotify \
      -iconv \
      -no-icu \
      -no-mimetype-database \
      -qt-pcre \
      -qt-zlib \
      -no-zstd \
      $( true network option ) \
      -no-openssl \
      $( true gui, printing, widget option ) \
      -no-cups \
      -no-fontconfig \
      -qt-freetype \
      -qt-harfbuzz \
      -no-gtk \
      -no-opengl \
      -xcb-xlib \
      -xcb \
      -bundled-xcb-xinput \
      -qt-libjpeg \
      -qt-libpng \
      $( true database option ) \
      -sql-sqlite \
      -qt-sqlite \
      $( true feature ) \
      -no-feature-wayland-server
  }
  popd
}
