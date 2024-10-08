function build_cross_binutils() {
  if [[ ! -d binutils-2.43.1 ]]; then
    if [[ ! -f $_ASSETS/binutils-2.43.1.tar.zst ]]; then
      curl -L -o $_ASSETS/binutils-2.43.1.tar.zst \
        https://ftpmirror.gnu.org/gnu/binutils/binutils-2.43.1.tar.zst
    fi
    tar xf $_ASSETS/binutils-2.43.1.tar.zst --no-same-owner
  fi
  mkdir -p binutils-2.43.1/build
  pushd binutils-2.43.1/build
  {
    ../configure \
      --target=$_TARGET \
      --host=x86_64-linux-gnu \
      --prefix=$_PREFIX \
      $( true === prefer static build === ) \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      $( true === features === ) \
      --enable-gold \
      --disable-install-libbfd \
      --disable-multilib \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_cross_linux_headers() {
  if [[ ! -d linux-headers-4.19.88-2 ]]; then
    if [[ ! -f $_ASSETS/linux-headers-4.19.88-2.tar.xz ]]; then
      curl -L -o $_ASSETS/linux-headers-4.19.88-2.tar.xz \
        https://github.com/sabotage-linux/kernel-headers/releases/download/v4.19.88-2/linux-headers-4.19.88-2.tar.xz
    fi
    tar xf $_ASSETS/linux-headers-4.19.88-2.tar.xz --no-same-owner
  fi
  pushd linux-headers-4.19.88-2
  {
    make ARCH=$_KERNAL_ARCH prefix=$_PREFIX/$_TARGET install
  }
  popd
}

function build_cross_gcc_p1() {
  if [[ ! -d gcc-14.2.0 ]]; then
    if [[ ! -f $_ASSETS/gcc-14.2.0.tar.xz ]]; then
      curl -L -o $_ASSETS/gcc-14.2.0.tar.xz \
        https://ftpmirror.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz
    fi
    tar xf $_ASSETS/gcc-14.2.0.tar.xz --no-same-owner
  fi
  mkdir -p gcc-14.2.0/build
  pushd gcc-14.2.0/build
  {
    ../configure \
      --target=$_TARGET \
      --host=x86_64-linux-gnu \
      --prefix=$_PREFIX \
      $( true === prefer static build === ) \
      --disable-shared \
      --enable-static \
      --with-static-standard-libraries \
      $( true === features === ) \
      --disable-bootstrap \
      --enable-host-pie \
      --enable-languages=c,c++ \
      --disable-libsanitizer \
      --enable-lto \
      --disable-multilib \
      $( true === packages === ) \
      --with-gmp=$_BUILDDIR/dep-host \
      --with-mpc=$_BUILDDIR/dep-host \
      --with-mpfr=$_BUILDDIR/dep-host \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s \
      CFLAGS_FOR_TARGET=-O2 CXXFLAGS_FOR_TARGET=-O2 LDFLAGS_FOR_TARGET=-s
    make -j$(nproc) all-gcc
    make install-gcc
  }
  popd
}

function build_cross_gcc_p2() {
  pushd gcc-14.2.0/build
  {
    make -j$(nproc) all-target-libgcc
    make install-target-libgcc
  }
  popd
}

function build_cross_gcc_p3() {
  pushd gcc-14.2.0/build
  {
    make -j$(nproc)
    make install
  }
  popd
}
