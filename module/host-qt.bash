function build_host_qtbase() {
  if [[ ! -d $_BUILDDIR/qtbase-everywhere-src-6.8.0 ]]; then
    tar -C $_BUILDDIR -xf assets/qtbase-everywhere-src-6.8.0.tar.xz --no-same-owner
    pushd $_BUILDDIR/qtbase-everywhere-src-6.8.0
    {
      patch -Np1 <$_PATCHDIR/qt-c-static-assert.patch
    }
    popd
  fi
  mkdir -p $_BUILDDIR/qtbase-everywhere-src-6.8.0/build-host
  pushd $_BUILDDIR/qtbase-everywhere-src-6.8.0/build-host
  {
    ../configure \
      -prefix /opt/qt \
      -archdatadir /opt/qt/lib/qt \
      -datadir /opt/qt/share/qt \
      $( true === configure meta === ) \
      -feature-xlib \
      $( true === build options === ) \
      -cmake-generator Ninja \
      -release \
      -static \
      -platform linux-g++ \
      -ltcg \
      -stack-protector \
      -unity-build \
      $( true === component selection === ) \
      -nomake examples \
      -dbus-linked \
      -accessibility \
      $( true === core options === ) \
      -qt-doubleconversion \
      -no-glib \
      -no-icu \
      -qt-pcre \
      -system-zlib \
      $( true === network options === ) \
      -no-ssl \
      -no-openssl \
      $( true === gui, printing, widget options === ) \
      -no-cups \
      -fontconfig \
      -system-freetype \
      -qt-harfbuzz \
      -no-gtk \
      -no-opengl \
      -qpa 'xcb;wayland' \
      -default-qpa wayland \
      -xcb-xlib \
      -xcb \
      -xkbcommon \
      -qt-libpng \
      -qt-libjpeg \
      $( true === database options === ) \
      -sql-sqlite \
      -qt-sqlite
    cmake --build . --parallel
    cmake --install .
  }
  popd
}

function build_host_xau() {
  if [[ ! -d $_BUILDDIR/libXau-1.0.11 ]]; then
    tar -C $_BUILDDIR -xf assets/libXau-1.0.11.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/libXau-1.0.11/build-host
  pushd $_BUILDDIR/libXau-1.0.11/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb() {
  if [[ ! -d $_BUILDDIR/libxcb-1.17.0 ]]; then
    tar -C $_BUILDDIR -xf assets/libxcb-1.17.0.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/libxcb-1.17.0/build-host
  pushd $_BUILDDIR/libxcb-1.17.0/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
    # merge libs -- workaround for Qt feature test
    ar -M <<<"
      create /opt/qt/lib/libxcb.a
      addlib src/.libs/libxcb.a
      addlib /opt/qt/lib/libXau.a
      save
      end"
  }
  popd
}

function build_host_xcb_proto() {
  if [[ ! -d $_BUILDDIR/xcb-proto-1.17.0 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-proto-1.17.0.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-proto-1.17.0/build-host
  pushd $_BUILDDIR/xcb-proto-1.17.0/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util() {
  if [[ ! -d $_BUILDDIR/xcb-util-0.4.1 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-0.4.1/build-host
  pushd $_BUILDDIR/xcb-util-0.4.1/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util_cursor() {
  if [[ ! -d $_BUILDDIR/xcb-util-cursor-0.1.5 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-cursor-0.1.5.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-cursor-0.1.5/build-host
  pushd $_BUILDDIR/xcb-util-cursor-0.1.5/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util_image() {
  if [[ ! -d $_BUILDDIR/xcb-util-image-0.4.1 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-image-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-image-0.4.1/build-host
  pushd $_BUILDDIR/xcb-util-image-0.4.1/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util_keysyms() {
  if [[ ! -d $_BUILDDIR/xcb-util-keysyms-0.4.1 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-keysyms-0.4.1.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-keysyms-0.4.1/build-host
  pushd $_BUILDDIR/xcb-util-keysyms-0.4.1/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util_renderutil() {
  if [[ ! -d $_BUILDDIR/xcb-util-renderutil-0.3.10 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-renderutil-0.3.10.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-renderutil-0.3.10/build-host
  pushd $_BUILDDIR/xcb-util-renderutil-0.3.10/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xcb_util_wm() {
  if [[ ! -d $_BUILDDIR/xcb-util-wm-0.4.2 ]]; then
    tar -C $_BUILDDIR -xf assets/xcb-util-wm-0.4.2.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/xcb-util-wm-0.4.2/build-host
  pushd $_BUILDDIR/xcb-util-wm-0.4.2/build-host
  {
    ../configure \
      --prefix /opt/qt \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xkbcommon() {
  if [[ ! -d $_BUILDDIR/libxkbcommon-1.7.0 ]]; then
    tar -C $_BUILDDIR -xf assets/libxkbcommon-1.7.0.tar.xz --no-same-owner
  fi
  pushd $_BUILDDIR/libxkbcommon-1.7.0
  {
    meson setup \
      --prefix /opt/qt \
      --default-library static \
      --prefer-static \
      -Denable-tools=false \
      --buildtype release --strip \
      build-host
    meson compile -C build-host
    meson install -C build-host
  }
  popd
}

function build_host_xml() {
  if [[ ! -d $_BUILDDIR/libxml2-2.13.4 ]]; then
    tar -C $_BUILDDIR -xf assets/libxml2-2.13.4.tar.xz --no-same-owner
  fi
  mkdir -p $_BUILDDIR/libxml2-2.13.4/build-host
  pushd $_BUILDDIR/libxml2-2.13.4/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --disable-shared \
      --enable-static \
      --without-python \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_xorgproto() {
  if [[ ! -d $_BUILDDIR/xorgproto-2024.1 ]]; then
    tar -C $_BUILDDIR -xf assets/xorgproto-2024.1.tar.xz --no-same-owner
  fi
  pushd $_BUILDDIR/xorgproto-2024.1
  {
    meson setup \
      --prefix /opt/qt \
      --default-library static \
      --prefer-static \
      --buildtype release --strip \
      build-host
    meson compile -C build-host
    meson install -C build-host
  }
  popd
}
