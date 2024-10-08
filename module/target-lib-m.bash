function build_target_musl_p1() {
  if [[ ! -d musl-1.2.5 ]]; then
    if [[ ! -f $_ASSETS/musl-1.2.5.tar.gz ]]; then
      curl -L -o $_ASSETS/musl-1.2.5.tar.gz \
        https://musl.libc.org/releases/musl-1.2.5.tar.gz
    fi
    tar xf $_ASSETS/musl-1.2.5.tar.gz --no-same-owner
  fi
  mkdir -p musl-1.2.5/build
  pushd musl-1.2.5/build
  {
    ../configure \
      --target=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
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
