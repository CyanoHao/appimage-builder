from hashlib import sha256
import logging
from packaging.version import Version
from pathlib import Path
import subprocess
from urllib.error import URLError
from urllib.request import urlopen

from module.checksum import CHECKSUMS
from module.path import ProjectPaths
from module.profile import BranchVersions, ProfileInfo


def _validate_and_download(path: Path, url: str):
  MAX_RETRY = 3
  checksum = CHECKSUMS[path.name]
  if path.exists():
    with open(path, 'rb') as f:
      body = f.read()
      if checksum != sha256(body).hexdigest():
        message = 'Validate fail: %s exists but checksum mismatch' % path.name
        logging.critical(message)
        logging.info('Please delete %s and try again' % path.name)
        raise Exception(message)
  else:
    logging.info('Downloading %s' % path.name)
    retry_count = 0
    while True:
      retry_count += 1
      try:
        response = urlopen(url)
        body = response.read()
        if checksum != sha256(body).hexdigest():
          message = 'Download fail: checksum mismatch for %s' % path.name
          logging.critical(message)
          raise Exception(message)
        with open(path, "wb") as f:
          f.write(body)
          return
      except URLError as e:
        message = 'Download fail: %s (retry %d/3)' % (e.reason, retry_count)
        if retry_count < MAX_RETRY:
          logging.warning(message)
          logging.warning('Retrying...')
        else:
          logging.critical(message)
          raise e

def _check_and_extract(path: Path, arx: Path):
  # check if already extracted
  if path.exists():
    mark = path / '.patched'
    if mark.exists():
      return False
    else:
      message = 'Extract fail: %s exists but not marked as fully patched' % path.name
      logging.critical(message)
      logging.info('Please delete %s and try again' % path.name)
      raise Exception(message)

  # extract
  res = subprocess.run([
    'bsdtar',
    '-xf',
    arx,
    '--no-same-owner',
  ], cwd = path.parent)
  if res.returncode != 0:
    message = 'Extract fail: bsdtar returned %d extracting %s' % (res.returncode, arx.name)
    logging.critical(message)
    raise Exception(message)

  return True

def _patch(path: Path, patch: Path):
  res = subprocess.run([
    'patch',
    '-Np1',
    '-i', patch,
  ], cwd = path)
  if res.returncode != 0:
    message = 'Patch fail: applying %s to %s' % (patch.name, path.name)
    logging.critical(message)
    raise Exception(message)

def _patch_done(path: Path):
  mark = path / '.patched'
  mark.touch()

def _binutils(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://ftpmirror.gnu.org/gnu/binutils/{paths.binutils_arx.name}'
  _validate_and_download(paths.binutils_arx, url)
  _check_and_extract(paths.binutils, paths.binutils_arx)
  _patch_done(paths.binutils)

def _gcc(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://ftpmirror.gnu.org/gcc/gcc-{ver}/{paths.gcc_arx.name}'
  _validate_and_download(paths.gcc_arx, url)
  _check_and_extract(paths.gcc, paths.gcc_arx)
  _patch_done(paths.gcc)

def _gmp(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://ftpmirror.gnu.org/gmp/{paths.gmp_arx.name}'
  _validate_and_download(paths.gmp_arx, url)
  _check_and_extract(paths.gmp, paths.gmp_arx)
  _patch_done(paths.gmp)

def _linux_headers(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://github.com/sabotage-linux/kernel-headers/releases/download/v{ver}/{paths.linux_headers_arx.name}'
  _validate_and_download(paths.linux_headers_arx, url)
  _check_and_extract(paths.linux_headers, paths.linux_headers_arx)
  _patch_done(paths.linux_headers)

def _mpc(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://ftpmirror.gnu.org/mpc/{paths.mpc_arx.name}'
  _validate_and_download(paths.mpc_arx, url)
  _check_and_extract(paths.mpc, paths.mpc_arx)
  _patch_done(paths.mpc)

def _mpfr(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://ftpmirror.gnu.org/mpfr/{paths.mpfr_arx.name}'
  _validate_and_download(paths.mpfr_arx, url)
  _check_and_extract(paths.mpfr, paths.mpfr_arx)
  _patch_done(paths.mpfr)

def _musl(ver: str, info: ProfileInfo, paths: ProjectPaths):
  url = f'https://www.musl-libc.org/releases/{paths.musl_arx.name}'
  _validate_and_download(paths.musl_arx, url)
  _check_and_extract(paths.musl, paths.musl_arx)
  _patch_done(paths.musl)

def _qtbase(ver: str, info: ProfileInfo, paths: ProjectPaths):
  v = Version(ver)
  branch = f'{v.major}.{v.minor}'
  url = f'https://download.qt.io/archive/qt/{branch}/{ver}/submodules/{paths.qtbase_arx.name}'
  _validate_and_download(paths.qtbase_arx, url)
  _check_and_extract(paths.qtbase, paths.qtbase_arx)
  _patch_done(paths.qtbase)

def _qtsvg(ver: str, info: ProfileInfo, paths: ProjectPaths):
  v = Version(ver)
  branch = f'{v.major}.{v.minor}'
  url = f'https://download.qt.io/archive/qt/{branch}/{ver}/submodules/{paths.qtsvg_arx.name}'
  _validate_and_download(paths.qtsvg_arx, url)
  _check_and_extract(paths.qtsvg, paths.qtsvg_arx)
  _patch_done(paths.qtsvg)

def _qttools(ver: str, info: ProfileInfo, paths: ProjectPaths):
  v = Version(ver)
  branch = f'{v.major}.{v.minor}'
  url = f'https://download.qt.io/archive/qt/{branch}/{ver}/submodules/{paths.qttools_arx.name}'
  _validate_and_download(paths.qttools_arx, url)
  _check_and_extract(paths.qttools, paths.qttools_arx)
  _patch_done(paths.qttools)

def _qttranslations(ver: str, info: ProfileInfo, paths: ProjectPaths):
  v = Version(ver)
  branch = f'{v.major}.{v.minor}'
  url = f'https://download.qt.io/archive/qt/{branch}/{ver}/submodules/{paths.qttranslations_arx.name}'
  _validate_and_download(paths.qttranslations_arx, url)
  _check_and_extract(paths.qttranslations, paths.qttranslations_arx)
  _patch_done(paths.qttranslations)

def _qtwayland(ver: str, info: ProfileInfo, paths: ProjectPaths):
  v = Version(ver)
  branch = f'{v.major}.{v.minor}'
  url = f'https://download.qt.io/archive/qt/{branch}/{ver}/submodules/{paths.qtwayland_arx.name}'
  _validate_and_download(paths.qtwayland_arx, url)
  _check_and_extract(paths.qtwayland, paths.qtwayland_arx)
  _patch_done(paths.qtwayland)

def download_and_patch(ver: BranchVersions, paths: ProjectPaths, info: ProfileInfo):
  _binutils(ver.binutils, info, paths)
  _gcc(ver.gcc, info, paths)
  _gmp(ver.gmp, info, paths)
  _linux_headers(ver.linux_headers, info, paths)
  _mpc(ver.mpc, info, paths)
  _mpfr(ver.mpfr, info, paths)
  _musl(ver.musl, info, paths)
  _qtbase(ver.qt, info, paths)
  _qtsvg(ver.qt, info, paths)
  _qttools(ver.qt, info, paths)
  _qttranslations(ver.qt, info, paths)
  _qtwayland(ver.qt, info, paths)
