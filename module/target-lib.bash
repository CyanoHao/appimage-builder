function build_target_musl_p1() {
  if [ ! -d musl-1.2.5 ]; then
    if [ ! -f "$_ASSSETS/musl-1.2.5.tar.gz" ]; then
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
  if [ ! -d expat-2.6.3 ]; then
    if [ ! -f "$_ASSSETS/expat-2.6.3.tar.xz" ]; then
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
  if [ ! -d dbus-1.14.10 ]; then
    if [ ! -f "$_ASSSETS/dbus-1.14.10.tar.xz" ]; then
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

function build_target_qt() {
  if [ ! -d qt-everywhere-src-5.15.15 ]; then
    if [ ! -f "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" ]; then
      curl -L -o "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" \
        https://download.qt.io/archive/qt/5.15/5.15.15/single/qt-everywhere-opensource-src-5.15.15.tar.xz
    fi
    tar xf "$_ASSSETS/qt-everywhere-opensource-src-5.15.15.tar.xz" --no-same-owner
    pushd qt-everywhere-src-5.15.15
    {
      ls | grep ^qt | grep -vE 'qt(\.pro|base|svg|tools|wayland|translations)' | xargs rm -r
    }
    popd
  fi
  mkdir -p qt-everywhere-src-5.15.15/build
  pushd qt-everywhere-src-5.15.15/build
  {
    ../configure -recheck-all \
      -prefix $_PREFIX/$_TARGET \
      -hostprefix $_PREFIX \
      -opensource -confirm-license \
      -static -platform linux-g++ \
      -xplatform linux-g++ -device-option CROSS_COMPILE=$_TARGET- \
      -no-feature-wayland-server \
      -nomake examples -nomake tests -nomake tools -dbus-linked \
      -qt-doubleconversion -no-glib -eventfd -inotify -iconv -no-icu -no-mimetype-database -qt-pcre -qt-zlib -no-zstd \
      -no-openssl \
      -no-cups -fontconfig -system-freetype -qt-harfbuzz -no-gtk -no-opengl -xcb-xlib \
      -xcb \
      -bundled-xcb-xinput \
      -qt-libjpeg -qt-libpng \
      -sql-sqlite -qt-sqlite
  }
  popd
}
