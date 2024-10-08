function build_target_expat() {
  if [[ ! -d expat-2.6.3 ]]; then
    if [[ ! -f $_ASSETS/expat-2.6.3.tar.xz ]]; then
      curl -L -o $_ASSETS/expat-2.6.3.tar.xz \
        https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
    fi
    tar xf $_ASSETS/expat-2.6.3.tar.xz --no-same-owner
  fi
  mkdir -p expat-2.6.3/build
  pushd expat-2.6.3/build
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
