import argparse
from typing import Optional

class BranchVersions:
  musl: str
  qt: str

  appimage_runtime: str = 'caf24f9f712084686bfc24a70b75e50df0aefb9c'
  binutils: str = '2.46.0'
  dbus: str = '1.16.2'
  expat: str = '2.7.5'
  fcitx_qt: str = '5.1.13'
  ffi: str = '3.5.2'
  fontconfig: str = '2.17.1'
  freetype: str = '2.14.3'
  fuse: str = '3.18.2'
  gcc: str = '15.2.0'
  gmp: str = '6.3.0'
  harfbuzz: str = '14.1.0'
  linux: str = '7.0'
  meson: str = '1.11.0'
  mimalloc: str = '3.3.0'
  mpc: str = '1.4.0'
  mpfr: str = '4.2.2'
  pkgconf: str = '2.5.1'
  png: str = '1.6.57'
  squashfuse: str = '0.6.1'
  wayland: str = '1.25.0'
  x: str = '1.8.13'
  xau: str = '1.0.12'
  xcb: str = '1.17.0'
  xcb_proto: str = '1.17.0'
  xcb_util: str = '0.4.1'
  xcb_util_cursor: str = '0.1.6'
  xcb_util_image: str = '0.4.1'
  xcb_util_keysyms: str = '0.4.1'
  xcb_util_renderutil: str = '0.3.10'
  xcb_util_wm: str = '0.4.2'
  xkbcommon: str = '1.13.1'
  xml: str = '2.15.2'
  xorg_proto: str = '2025.1'
  xtrans: str = '1.6.0'
  z: str = '2.3.3'
  zstd: str = '1.5.7'

  def __init__(
    self,

    musl: str,
    qt: str,
  ):
    self.musl = musl
    self.qt = qt

class ProfileInfo:
  arch: str
  kernel_arch: str
  target: str
  with_arch: Optional[str]

  def __init__(
    self,
    arch: str,
    triplet_arch: str,
    kernel_arch: str,
    with_arch: Optional[str] = None,
  ):
    self.arch = arch
    self.kernel_arch = kernel_arch
    self.target = f'{triplet_arch}-linux-musl'
    self.with_arch = with_arch

class BranchProfile(BranchVersions):
  arch: str
  kernel_arch: str
  target: str
  with_arch: Optional[str]

  def __init__(
    self,
    ver: BranchVersions,
    info: ProfileInfo,
  ):
    BranchVersions.__init__(self, **ver.__dict__)

    self.arch = info.arch
    self.kernel_arch = info.kernel_arch
    self.target = info.target
    self.with_arch = info.with_arch

BRANCHES = {
  'main': BranchVersions(
    musl = '1.2.6',
    qt = '6.11.0',
  ),
  'time32': BranchVersions(
    musl = '1.1.24',
    qt = '6.8.3',
  ),
}

PROFILES = {
  'x86_64': ProfileInfo(
    arch = 'x86_64',
    triplet_arch = 'x86_64',
    kernel_arch = 'x86',
  ),
  'x86_64.v3': ProfileInfo(
    arch = 'x86_64.v3',
    triplet_arch = 'x86_64',
    kernel_arch = 'x86',
    with_arch = 'x86-64-v3',
  ),
  'aarch64': ProfileInfo(
    arch = 'aarch64',
    triplet_arch = 'aarch64',
    kernel_arch = 'arm64',
  ),
  'riscv64': ProfileInfo(
    arch = 'riscv64',
    triplet_arch = 'riscv64',
    kernel_arch = 'riscv',
  ),
  'loong64': ProfileInfo(
    arch = 'loong64',
    triplet_arch = 'loongarch64',
    kernel_arch = 'loongarch',
  ),
  'i686': ProfileInfo(
    arch = 'i686',
    triplet_arch = 'i686',
    kernel_arch = 'x86',
  ),
}

def resolve_profile(config: argparse.Namespace) -> BranchProfile:
  return BranchProfile(
    ver = BRANCHES[config.branch],
    info = PROFILES[config.arch],
  )
