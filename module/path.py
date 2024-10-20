import argparse
from pathlib import Path

from module.profile import BranchVersions, ProfileInfo

class ProjectPaths:
  root: Path

  assets: Path
  dist: Path
  patch: Path

  build: Path
  h_prefix: Path
  prefix: Path

  arx: Path

  binutils: Path
  gcc: Path
  gmp: Path
  linux_headers: Path
  mpc: Path
  mpfr: Path
  musl: Path
  qtbase: Path
  qtsvg: Path
  qttools: Path
  qttranslations: Path
  qtwayland: Path

  binutils_arx: Path
  gcc_arx: Path
  gmp_arx: Path
  linux_headers_arx: Path
  mpc_arx: Path
  mpfr_arx: Path
  musl_arx: Path
  qtbase_arx: Path
  qtsvg_arx: Path
  qttools_arx: Path
  qttranslations_arx: Path
  qtwayland_arx: Path

  def __init__(
    self,
    config: argparse.Namespace,
    ver: BranchVersions,
    info: ProfileInfo,
  ):
    self.root = Path.cwd()

    self.assets = self.root / 'assets'
    self.dist = self.root / 'dist'
    self.patch = self.root / 'patch'

    self.build = Path(f'/tmp/build/{info.arch}')
    self.h_prefix = Path(f'/opt/qt-{info.arch}')
    self.prefix = Path(f'/opt/qt-{info.arch}/{info.target}')

    self.arx = f'qt-{config.arch}-{ver.qt}-r{ver.rev}.tar.zst'

    binutils = f'binutils-{ver.binutils}'
    self.binutils = self.build / binutils
    self.binutils_arx = self.assets / f'{binutils}.tar.zst'

    gcc = f'gcc-{ver.gcc}'
    self.gcc = self.build / gcc
    self.gcc_arx = self.assets / f'{gcc}.tar.xz'

    gmp = f'gmp-{ver.gmp}'
    self.gmp = self.build / gmp
    self.gmp_arx = self.assets / f'{gmp}.tar.zst'

    linux_headers = f'linux-headers-{ver.linux_headers}'
    self.linux_headers = self.build / linux_headers
    self.linux_headers_arx = self.assets / f'{linux_headers}.tar.xz'

    mpc = f'mpc-{ver.mpc}'
    self.mpc = self.build / mpc
    self.mpc_arx = self.assets / f'{mpc}.tar.gz'

    mpfr = f'mpfr-{ver.mpfr}'
    self.mpfr = self.build / mpfr
    self.mpfr_arx = self.assets / f'{mpfr}.tar.xz'

    musl = f'musl-{ver.musl}'
    self.musl = self.build / musl
    self.musl_arx = self.assets / f'{musl}.tar.gz'

    qtbase = f'qtbase-everywhere-src-{ver.qt}'
    self.qtbase = self.build / qtbase
    self.qtbase_arx = self.assets / f'{qtbase}.tar.xz'

    qtsvg = f'qtsvg-everywhere-src-{ver.qt}'
    self.qtsvg = self.build / qtsvg
    self.qtsvg_arx = self.assets / f'{qtsvg}.tar.xz'

    qttools = f'qttools-everywhere-src-{ver.qt}'
    self.qttools = self.build / qttools
    self.qttools_arx = self.assets / f'{qttools}.tar.xz'

    qttranslations = f'qttranslations-everywhere-src-{ver.qt}'
    self.qttranslations = self.build / qttranslations
    self.qttranslations_arx = self.assets / f'{qttranslations}.tar.xz'

    qtwayland = f'qtwayland-everywhere-src-{ver.qt}'
    self.qtwayland = self.build / qtwayland
    self.qtwayland_arx = self.assets / f'{qtwayland}.tar.xz'

