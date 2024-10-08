function build_host_wayland_scanner() {
  if [[ ! -d wayland-1.23.1 ]]; then
    if [[ ! -f $_ASSETS/wayland-1.23.1.tar.xz ]]; then
      curl -L -o $_ASSETS/wayland-1.23.1.tar.xz \
        https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.1/downloads/wayland-1.23.1.tar.xz
    fi
    tar -xf $_ASSETS/wayland-1.23.1.tar.xz --no-same-owner
  fi
  pushd wayland-1.23.1
  {
    meson setup \
      --prefix $_PREFIX \
      --libdir=lib \
      --default-library static \
      --prefer-static \
      $( true === features === ) \
      -Ddocumentation=false \
      -Ddtd_validation=false \
      -Dlibraries=false \
      -Dscanner=true \
      -Dtests=false \
      --buildtype release --strip \
      build-host
    meson compile -C build-host
    meson install -C build-host
  }
  popd
}
