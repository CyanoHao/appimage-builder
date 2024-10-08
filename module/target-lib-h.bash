function build_target_harfbuzz() {
  if [[ ! -d harfbuzz-10.0.1 ]]; then
    if [[ ! -f $_ASSETS/harfbuzz-10.0.1.tar.xz ]]; then
      curl -L -o $_ASSETS/harfbuzz-10.0.1.tar.xz \
        https://github.com/harfbuzz/harfbuzz/releases/download/10.0.1/harfbuzz-10.0.1.tar.xz
    fi
    tar xf $_ASSETS/harfbuzz-10.0.1.tar.xz --no-same-owner
  fi
  pushd harfbuzz-10.0.1
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      -Ddocs=disabled \
      -Dfreetype=enabled \
      -Dglib=disabled \
      -Dgobject=disabled \
      -Dtests=disabled \
      -Dutilities=disabled \
      --buildtype release --strip \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}
