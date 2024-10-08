function build_target_ffi() {
  if [[ ! -d libffi-3.4.6 ]]; then
    if [[ ! -f $_ASSETS/libffi-3.4.6.tar.gz ]]; then
      curl -L -o $_ASSETS/libffi-3.4.6.tar.gz \
        https://github.com/libffi/libffi/releases/download/v3.4.6/libffi-3.4.6.tar.gz
    fi
    tar xf $_ASSETS/libffi-3.4.6.tar.gz --no-same-owner
  fi
  mkdir -p libffi-3.4.6/build
  pushd libffi-3.4.6/build
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

function build_target_fontconfig() {
  if [[ ! -d fontconfig-2.15.0 ]]; then
    if [[ ! -f $_ASSETS/fontconfig-2.15.0.tar.gz ]]; then
      curl -L -o $_ASSETS/fontconfig-2.15.0.tar.gz \
        https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.15.0.tar.gz
    fi
    tar xf $_ASSETS/fontconfig-2.15.0.tar.gz --no-same-owner
  fi
  pushd fontconfig-2.15.0
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      -Ddoc=disabled \
      -Dtests=disabled \
      -Dtools=disabled \
      -Dnls=disabled \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}

function build_target_freetype() {
  # source prepared by freetype[decycle]
  mkdir -p freetype-2.13.3/build
  pushd freetype-2.13.3/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      $( true === features === ) \
      --with-harfbuzz \
      --with-png \
      --with-zlib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_freetype_decycle() {
  if [[ ! -d freetype-2.13.3 ]]; then
    if [[ ! -f $_ASSETS/freetype-2.13.3.tar.xz ]]; then
      curl -L -o $_ASSETS/freetype-2.13.3.tar.xz \
        https://download-mirror.savannah.gnu.org/releases/freetype/freetype-2.13.3.tar.xz
    fi
    tar xf $_ASSETS/freetype-2.13.3.tar.xz --no-same-owner
  fi
  mkdir -p freetype-2.13.3/build-decycle
  pushd freetype-2.13.3/build-decycle
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      $( true === features === ) \
      --without-harfbuzz \
      --without-png \
      --without-zlib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}
