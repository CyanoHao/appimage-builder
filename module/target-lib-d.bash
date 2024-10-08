function build_target_dbus() {
  if [[ ! -d dbus-1.14.10 ]]; then
    if [[ ! -f $_ASSETS/dbus-1.14.10.tar.xz ]]; then
      curl -L -o $_ASSETS/dbus-1.14.10.tar.xz \
        https://dbus.freedesktop.org/releases/dbus/dbus-1.14.10.tar.xz
    fi
    tar xf $_ASSETS/dbus-1.14.10.tar.xz --no-same-owner
  fi
  mkdir -p dbus-1.14.10/build
  pushd dbus-1.14.10/build
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

function build_target_double_conversion() {
  if [[ ! -d double-conversion-3.3.0 ]]; then
    if [[ ! -f $_ASSETS/double-conversion-3.3.0.tar.xz ]]; then
      curl -L -o $_ASSETS/double-conversion-3.3.0.tar.xz \
        https://github.com/google/double-conversion/archive/v3.3.0.tar.gz
    fi
    tar xf $_ASSETS/double-conversion-3.3.0.tar.xz --no-same-owner
  fi
  pushd double-conversion-3.3.0
  {
    cmake \
      $_CMAKE_CROSS \
      -DCMAKE_INSTALL_PREFIX=$_PREFIX/$_TARGET \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -B build
    cmake --build build --parallel
    cmake --install build
  }
  popd
}
