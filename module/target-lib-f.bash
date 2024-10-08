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
