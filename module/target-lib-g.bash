function build_target_glib() {
  if [[ ! -d glib-2.82.1 ]]; then
    if [[ ! -f $_ASSETS/glib-2.82.1.tar.xz ]]; then
      curl -L -o $_ASSETS/glib-2.82.1.tar.xz \
        https://download.gnome.org/sources/glib/2.82/glib-2.82.1.tar.xz
    fi
    tar -xf $_ASSETS/glib-2.82.1.tar.xz
  fi
  pushd glib-2.82.1
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
