function build_target_at_spi() {
  if [[ ! -d at-spi2-core-2.54.0 ]]; then
    if [[ ! -f $_ASSETS/at-spi2-core-2.54.0.tar.xz ]]; then
      curl -L -o $_ASSETS/at-spi2-core-2.54.0.tar.xz \
        https://download.gnome.org/sources/at-spi2-core/2.54/at-spi2-core-2.54.0.tar.xz
    fi
    tar -xf $_ASSETS/at-spi2-core-2.54.0.tar.xz
  fi
  pushd at-spi2-core-2.54.0
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
