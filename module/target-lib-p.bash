function build_target_pcre() {
  if [[ ! -d pcre2-10.44 ]]; then
    if [[ ! -f $_ASSETS/pcre2-10.44.tar.bz2 ]]; then
      curl -L -o $_ASSETS/pcre2-10.44.tar.bz2 \
        https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.bz2
    fi
    tar -xf $_ASSETS/pcre2-10.44.tar.bz2 --no-same-owner
  fi
  mkdir -p pcre2-10.44/build
  pushd pcre2-10.44/build
  {
    ../configure \
      --host=$_TARGET \
      --prefix=$_PREFIX/$_TARGET \
      --disable-shared \
      --enable-static \
      $( true === features === ) \
      --enable-pcre2-8 \
      --enable-pcre2-16 \
      --disable-pcre2-32 \
      CFLAGS=-O2 CXXFLAGS=-O2 LDFLAGS=-s
    make -j$(nproc)
    make install
  }
  popd
}

function build_target_png() {
  if [[ ! -d libpng-1.6.44 ]]; then
    if [[ ! -f $_ASSETS/libpng-1.6.44.tar.xz ]]; then
      curl -L -o $_ASSETS/libpng-1.6.44.tar.xz \
        https://sourceforge.net/projects/libpng/files/libpng16/1.6.44/libpng-1.6.44.tar.xz/download
    fi
    tar -xf $_ASSETS/libpng-1.6.44.tar.xz --no-same-owner
  fi
  mkdir -p libpng-1.6.44/build
  pushd libpng-1.6.44/build
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
