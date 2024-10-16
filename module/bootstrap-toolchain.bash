function build_bootstrap_binutils() {
  if [[ ! -d $_BUILDDIR/binutils-2.35.2 ]]; then
    tar -C $_BUILDDIR -xf assets/binutils-2.35.2.tar.xz
  fi
  mkdir -p $_BUILDDIR/binutils-2.35.2/build-bootstrap
  pushd $_BUILDDIR/binutils-2.35.2/build-bootstrap
  {
    ../configure \
      --prefix=/opt/bootstrap \
      --libexecdir=/opt/bootstrap/lib \
      --libdir=/opt/bootstrap/lib \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      --disable-multilib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make tooldir=/opt/bootstrap install
  }
  popd
}

function build_bootstrap_gcc() {
  if [[ ! -d $_BUILDDIR/gcc-9.5.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gcc-9.5.0.tar.xz
  fi
  mkdir -p $_BUILDDIR/gcc-9.5.0/build-bootstrap
  pushd $_BUILDDIR/gcc-9.5.0/build-bootstrap
  {
    ../configure \
      --prefix=/opt/bootstrap \
      --libexecdir=/opt/bootstrap/lib \
      --libdir=/opt/bootstrap/lib \
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
      --with-gmp=/opt/bootstrap \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s \
      CFLAGS_FOR_TARGET=-O2 CXXFLAGS_FOR_TARGET=-O2 LDFLAGS_FOR_TARGET=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_bootstrap_gmp() {
  if [[ ! -d $_BUILDDIR/gmp-6.3.0 ]]; then
    tar -C $_BUILDDIR -xf assets/gmp-6.3.0.tar.xz
  fi
  mkdir -p $_BUILDDIR/gmp-6.3.0/build-bootstrap
  pushd $_BUILDDIR/gmp-6.3.0/build-bootstrap
  {
    ../configure \
      --prefix=/opt/bootstrap \
      --enable-static \
      --disable-shared \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_bootstrap_mpc() {
  if [[ ! -d $_BUILDDIR/mpc-1.3.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpc-1.3.1.tar.gz
  fi
  mkdir -p $_BUILDDIR/mpc-1.3.1/build-bootstrap
  pushd $_BUILDDIR/mpc-1.3.1/build-bootstrap
  {
    ../configure \
      --prefix=/opt/bootstrap \
      --enable-static \
      --disable-shared \
      --with-gmp=/opt/bootstrap \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_bootstrap_mpfr() {
  if [[ ! -d $_BUILDDIR/mpfr-4.2.1 ]]; then
    tar -C $_BUILDDIR -xf assets/mpfr-4.2.1.tar.xz
  fi
  mkdir -p $_BUILDDIR/mpfr-4.2.1/build-bootstrap
  pushd $_BUILDDIR/mpfr-4.2.1/build-bootstrap
  {
    ../configure \
      --prefix=/opt/bootstrap \
      --enable-static \
      --disable-shared \
      --with-gmp=/opt/bootstrap \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}
