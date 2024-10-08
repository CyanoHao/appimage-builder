function build_target_wayland() {
  # source prepared by host wayland-scanner
  pushd wayland-1.23.1
  {
    meson setup \
      $_MESON_CROSS \
      --prefix $_PREFIX/$_TARGET \
      --default-library static \
      --prefer-static \
      $( true === features === ) \
      -Ddocumentation=false \
      -Dscanner=false \
      -Dtests=false \
      --buildtype release --strip \
      -Dbuild.pkg_config_path=$_PREFIX/lib/pkgconfig \
      build
    meson compile -C build
    meson install -C build
  }
  popd
}
