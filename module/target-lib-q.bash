function build_target_qt() {
  if [[ ! -d qt-everywhere-src-5.15.15 ]]; then
    if [[ ! -f $_ASSETS/qt-everywhere-opensource-src-5.15.15.tar.xz ]]; then
      curl -L -o $_ASSETS/qt-everywhere-opensource-src-5.15.15.tar.xz \
        https://download.qt.io/archive/qt/5.15/5.15.15/single/qt-everywhere-opensource-src-5.15.15.tar.xz
    fi
    tar xf $_ASSETS/qt-everywhere-opensource-src-5.15.15.tar.xz --no-same-owner
    pushd qt-everywhere-src-5.15.15
    {
      patch -Np1 <$_PATCHDIR/qt-static-xlib.patch
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
    env PKG_CONFIG="pkg-config --static" \
      ../configure \
        -prefix $_PREFIX/$_TARGET \
        -hostprefix $_PREFIX \
        $( true === configure meta ===) \
        -recheck \
        -no-feature-wayland-server \
        $( true === build options === ) \
        -opensource \
        -confirm-license \
        -debug \
        -static \
        -platform linux-g++ \
        -device linux-generic-g++ \
        -device-option CROSS_COMPILE=$_TARGET- \
        -no-ltcg \
        -linker gold \
        $( true === build environment === ) \
        -sysroot / \
        -no-gcc-sysroot \
        -pkg-config \
        $( true === component selection === ) \
        -nomake examples \
        -nomake tests \
        -nomake tools \
        -dbus-linked \
        $( true === core options === ) \
        -system-doubleconversion \
        -glib \
        -eventfd \
        -inotify \
        -iconv \
        -no-icu \
        -no-mimetype-database \
        -system-pcre \
        -system-zlib \
        -zstd \
        $( true === network options === ) \
        -no-openssl \
        $( true === gui, printing, widget options === ) \
        -no-cups \
        -fontconfig \
        -system-freetype \
        -system-harfbuzz \
        -no-gtk \
        -no-opengl \
        -xcb-xlib \
        -xcb \
        -system-libjpeg \
        -system-libpng \
        $( true === database options === ) \
        -sql-sqlite \
        -system-sqlite
    make -j$(nproc)
    make install
  }
  popd
}
