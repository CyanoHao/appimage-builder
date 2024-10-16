function build_host_binutils() {
  if [[ ! -d $_BUILDDIR/binutils-2.35.2 ]]; then
    tar -C $_BUILDDIR -xf assets/binutils-2.35.2.tar.xz
  fi
  mkdir -p $_BUILDDIR/binutils-2.35.2/build-host
  pushd $_BUILDDIR/binutils-2.35.2/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --libexecdir=/opt/qt/lib \
      --libdir=/opt/qt/lib \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      --disable-multilib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make tooldir=/opt/qt install
  }
  popd
}

function build_host_cmake() {
  if [[ ! -d $_BUILDDIR/cmake-3.30.5 ]]; then
    tar -C $_BUILDDIR -xf assets/cmake-3.30.5.tar.gz
  fi
  bash
  mkdir -p $_BUILDDIR/cmake-3.30.5/build-host
  pushd $_BUILDDIR/cmake-3.30.5/build-host
  {
    ../bootstrap \
      --prefix=/opt/qt \
      --parallel=$(nproc) \
      --generator="Unix Makefiles" \
      --no-system-libs \
      --no-qt-gui \
      --no-debugger \
      -- \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_BUILD_TYPE=Release
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_gcc() {
  if [[ ! -d $_BUILDDIR/gcc-14.2.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gcc-14.2.0.tar.xz
  fi
  mkdir -p $_BUILDDIR/gcc-14.2.0/build-host
  pushd $_BUILDDIR/gcc-14.2.0/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --libexecdir=/opt/qt/lib \
      --libdir=/opt/qt/lib \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      $( true === features === ) \
      --disable-bootstrap \
      --enable-default-pie \
      --enable-host-pie \
      --enable-languages=c,c++ \
      --disable-libcc1 \
      --disable-libsanitizer \
      --enable-lto \
      --disable-multilib \
      $( true === packages === ) \
      --with-gcc-major-version-only \
      --with-gmp=/opt/qt \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s \
      CFLAGS_FOR_TARGET=-O2 CXXFLAGS_FOR_TARGET=-O2 LDFLAGS_FOR_TARGET=-s
    make -j$(nproc) || make -j1
    make install
  }
  popd
}

function build_host_gmp() {
  if [[ ! -d $_BUILDDIR/gmp-6.3.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gmp-6.3.0.tar.xz
  fi
  mkdir -p $_BUILDDIR/gmp-6.3.0/build-host
  pushd $_BUILDDIR/gmp-6.3.0/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --enable-static \
      --disable-shared \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_mpc() {
  if [[ ! -d $_BUILDDIR/mpc-1.3.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpc-1.3.1.tar.gz
  fi
  mkdir -p $_BUILDDIR/mpc-1.3.1/build-host
  pushd $_BUILDDIR/mpc-1.3.1/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --enable-static \
      --disable-shared \
      --with-gmp=/opt/qt \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_mpfr() {
  if [[ ! -d $_BUILDDIR/mpfr-4.2.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpfr-4.2.1.tar.xz
  fi
  mkdir -p $_BUILDDIR/mpfr-4.2.1/build-host
  pushd $_BUILDDIR/mpfr-4.2.1/build-host
  {
    ../configure \
      --prefix=/opt/qt \
      --enable-static \
      --disable-shared \
      --with-gmp=/opt/qt \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_ninja() {
  false
}
