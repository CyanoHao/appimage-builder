function build_host_zstd() {
  if [[ ! -d $_BUILDDIR/zstd-1.5.6 ]]; then
    tar -C $_BUILDDIR -xf assets/zstd-1.5.6.tar.gz
  fi
  pushd $_BUILDDIR/zstd-1.5.6/build/meson
  {
    meson setup \
      --prefix /opt/qt \
      --default-library static \
      --prefer-static \
      --buildtype release --strip \
      build-host
    meson compile -C build-host
    meson install -C build-host
  }
  popd
}
