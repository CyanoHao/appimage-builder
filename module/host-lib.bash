function build_host_gmp() {
  if [[ ! -d gmp-6.3.0 ]]; then
    if [[ ! -f $_ASSETS/gmp-6.3.0.tar.zst ]]; then
      curl -L -o $_ASSETS/gmp-6.3.0.tar.zst \
        https://ftpmirror.gnu.org/gnu/gmp/gmp-6.3.0.tar.zst
    fi
    tar xf $_ASSETS/gmp-6.3.0.tar.zst --no-same-owner
  fi
  mkdir -p gmp-6.3.0/build-host
  pushd gmp-6.3.0/build-host
  {
    ../configure \
      --target=x86_64-linux-gnu \
      --host=x86_64-linux-gnu \
      --prefix=$_BUILDDIR/dep-host \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_mpfr() {
  if [[ ! -d mpfr-4.2.1 ]]; then
    if [[ ! -f $_ASSETS/mpfr-4.2.1.tar.xz ]]; then
      curl -L -o $_ASSETS/mpfr-4.2.1.tar.xz \
        https://ftpmirror.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz
    fi
    tar xf $_ASSETS/mpfr-4.2.1.tar.xz --no-same-owner
  fi
  mkdir -p mpfr-4.2.1/build-host
  pushd mpfr-4.2.1/build-host
  {
    ../configure \
      --target=x86_64-linux-gnu \
      --host=x86_64-linux-gnu \
      --prefix=$_BUILDDIR/dep-host \
      --disable-shared \
      --enable-static \
      --with-gmp=$_BUILDDIR/dep-host \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_host_mpc() {
  if [[ ! -d mpc-1.3.1 ]]; then
    if [[ ! -f $_ASSETS/mpc-1.3.1.tar.gz ]]; then
      curl -L -o $_ASSETS/mpc-1.3.1.tar.gz \
        https://ftpmirror.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
    fi
    tar xf $_ASSETS/mpc-1.3.1.tar.gz --no-same-owner
  fi
  mkdir -p mpc-1.3.1/build-host
  pushd mpc-1.3.1/build-host
  {
    ../configure \
      --target=x86_64-linux-gnu \
      --host=x86_64-linux-gnu \
      --prefix=$_BUILDDIR/dep-host \
      --disable-shared \
      --enable-static \
      --with-gmp=$_BUILDDIR/dep-host \
      --with-mpfr=$_BUILDDIR/dep-host \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}
