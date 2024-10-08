function build_target_sqlite() {
  if [[ ! -d sqlite-autoconf-3460100 ]]; then
    if [[ ! -f $_ASSETS/sqlite-autoconf-3460100.tar.gz ]]; then
      curl -L -o $_ASSETS/sqlite-autoconf-3460100.tar.gz \
        https://www.sqlite.org/2024/sqlite-autoconf-3460100.tar.gz
    fi
    tar -xf $_ASSETS/sqlite-autoconf-3460100.tar.gz --no-same-owner
  fi
  mkdir -p sqlite-autoconf-3460100/build
  pushd sqlite-autoconf-3460100/build
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
