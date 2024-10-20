class BranchVersions:
  qt: str
  rev: str

  binutils: str
  gcc: str
  gmp: str
  linux_headers: str
  mpc: str
  mpfr: str
  musl: str

  def __init__(
    self,

    qt: str,
    rev: str,

    binutils: str,
    gcc: str,
    gmp: str,
    linux_headers: str,
    mpc: str,
    mpfr: str,
    musl: str,
  ):
    self.qt = qt
    self.rev = rev

    self.binutils = binutils
    self.gcc = gcc
    self.gmp = gmp
    self.linux_headers = linux_headers
    self.mpc = mpc
    self.mpfr = mpfr
    self.musl = musl

class ProfileInfo:
  arch: str
  host: str
  kernel_arch: str
  target: str

  def __init__(
    self,
    arch: str,
    kernel_arch: str,
  ):
    self.arch = arch
    self.host = 'x86_64-linux-gnu'
    self.kernel_arch = kernel_arch
    self.target = f'{arch}-linux-musl'

class FullProfile:
  ver: BranchVersions
  info: ProfileInfo

  def __init__(
    self,
    ver: BranchVersions,
    info: ProfileInfo
  ):
    self.ver = ver
    self.info = info

BRANCHES = {
  '6.8': BranchVersions(
    qt = '6.8.0',
    rev = '0',

    binutils = '2.43.1',
    gcc = '14.2.0',
    gmp = '6.3.0',
    linux_headers = '4.19.88-2',
    mpc = '1.3.1',
    mpfr = '4.2.1',
    musl = '1.2.5',
  ),
}

PROFILES = {
  'x86_64': ProfileInfo(
    arch = 'x86_64',
    kernel_arch = 'x86',
  ),
  'aarch64': ProfileInfo(
    arch = 'aarch64',
    kernel_arch = 'arm64',
  ),
  'riscv64': ProfileInfo(
    arch = 'riscv64',
    kernel_arch = 'riscv',
  ),
  'i686': ProfileInfo(
    arch = 'i686',
    kernel_arch = 'x86',
  ),
  'armv7l': ProfileInfo(
    arch = 'armv7l',
    kernel_arch = 'arm',
  ),
}

def get_full_profile(config) -> FullProfile:
  return FullProfile(
    ver = BRANCHES['6.8'],
    info = PROFILES[config.arch],
  )
