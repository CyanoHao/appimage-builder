function build_target_jpeg_turbo() {
  if [[ ! -d libjpeg-turbo-3.0.4 ]]; then
    if [[ ! -f $_ASSETS/libjpeg-turbo-3.0.4.tar.xz ]]; then
      curl -L -o $_ASSETS/libjpeg-turbo-3.0.4.tar.xz \
        https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.0.4/libjpeg-turbo-3.0.4.tar.gz
    fi
    tar xf $_ASSETS/libjpeg-turbo-3.0.4.tar.xz --no-same-owner
  fi
  pushd libjpeg-turbo-3.0.4
  {
    cmake \
      $_CMAKE_CROSS \
      -DCMAKE_INSTALL_PREFIX=$_PREFIX/$_TARGET \
      -DENABLE_SHARED=OFF \
      -DENABLE_STATIC=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -B build
    cmake --build build --parallel
    cmake --install build
  }
  popd
}
