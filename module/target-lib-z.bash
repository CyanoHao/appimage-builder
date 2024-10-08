function build_target_zlib() {
  if [[ ! -d zlib-1.3.1 ]]; then
    if [[ ! -f $_ASSETS/zlib-1.3.1.tar.xz ]]; then
      curl -L -o $_ASSETS/zlib-1.3.1.tar.xz \
        https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.xz
    fi
    tar -xf $_ASSETS/zlib-1.3.1.tar.xz --no-same-owner
  fi
  pushd zlib-1.3.1
  {
    cmake \
      $_CMAKE_CROSS \
      -DCMAKE_INSTALL_PREFIX=$_PREFIX/$_TARGET \
      -DBUILD_SHARED_LIBS=OFF \
      -DZLIB_BUILD_EXAMPLES=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -B build
    cmake --build build --parallel
    cmake --install build
    rm $_PREFIX/$_TARGET/lib/libz.so*
  }
  popd
}

function build_target_zstd() {
  if [[ ! -d zstd-1.5.6 ]]; then
    if [[ ! -f $_ASSETS/zstd-1.5.6.tar.zst ]]; then
      curl -L -o $_ASSETS/zstd-1.5.6.tar.zst \
        https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.zst
    fi
    tar -xf $_ASSETS/zstd-1.5.6.tar.zst --no-same-owner
  fi
  pushd zstd-1.5.6/build/meson
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}
