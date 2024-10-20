import argparse
import logging
from packaging.version import Version
from shutil import copyfile
import subprocess

from module.debug import shell_here
from module.path import ProjectPaths
from module.profile import BranchVersions, ProfileInfo
from module.util import cflags_host, cmake_build, cmake_install, configure, ensure, make_default, make_install

def _gmp(ver: str, paths: ProjectPaths, info: ProfileInfo, jobs: int):
  build_dir = paths.gmp / 'build-host'
  ensure(build_dir)
  configure('gmp', build_dir, [
    f'--prefix={paths.h_prefix}',
    '--disable-assembly',
    '--enable-static',
    '--disable-shared',
    *cflags_host(),
  ])
  make_default('gmp', build_dir, jobs)
  make_install('gmp', build_dir)

def _mpfr(ver: str, paths: ProjectPaths, info: ProfileInfo, jobs: int):
  build_dir = paths.mpfr / 'build-host'
  ensure(build_dir)
  configure('mpfr', build_dir, [
    f'--prefix={paths.h_prefix}',
    f'--with-gmp={paths.h_prefix}',
    '--enable-static',
    '--disable-shared',
    *cflags_host(),
  ])
  make_default('mpfr', build_dir, jobs)
  make_install('mpfr', build_dir)

def _mpc(ver: str, paths: ProjectPaths, info: ProfileInfo, jobs: int):
  build_dir = paths.mpc / 'build-host'
  ensure(build_dir)
  configure('mpc', build_dir, [
    f'--prefix={paths.h_prefix}',
    f'--with-gmp={paths.h_prefix}',
    f'--with-mpfr={paths.h_prefix}',
    '--enable-static',
    '--disable-shared',
    *cflags_host(),
  ])
  make_default('mpc', build_dir, jobs)
  make_install('mpc', build_dir)

def _qtbase(ver: str, paths: ProjectPaths, info: ProfileInfo, jobs: int):
  build_dir = paths.qtbase / 'build-host'
  ensure(build_dir)
  configure('qtbase', build_dir, [
    '-prefix', paths.h_prefix,
    '-archdatadir', f'{paths.h_prefix}/lib/qt',
    '-libexecdir', f'{paths.h_prefix}/lib/qt/bin',
    '-datadir', f'{paths.h_prefix}/share/qt',
    '-hostdatadir', f'{paths.h_prefix}/share/qt/mkspecs',
    # configure meta
    # build options
    '-cmake-generator', 'Ninja',
    '-release',
    '-gc-binaries',
    '-static',
    '-platform', 'linux-g++',
    '-pch',
    '-ltcg',
    '-linker', 'gold',
    '-unity-build',
    # build environment
    # component selection
    '-nomake', 'examples',
    '-no-gui',
    '-no-dbus',
    # core options
    '-qt-doubleconversion',
    '-no-glib',
    '-no-icu',
    '-qt-pcre',
    '-qt-zlib',
    # network options
    '-no-ssl',
    # gui, printing, widget options
    '-no-cups',
    '-no-libpng',
    '-no-libjpeg',
    # database options
    '-sql-sqlite',
    '-qt-sqlite',
  ])
  cmake_build('qtbase', build_dir, jobs)
  cmake_install('qtbase', build_dir)

def build_host_lib(ver: BranchVersions, paths: ProjectPaths, info: ProfileInfo, config: argparse.Namespace):
  _gmp(ver.gmp, paths, info, config.jobs)

  _mpfr(ver.mpfr, paths, info, config.jobs)

  _mpc(ver.mpc, paths, info, config.jobs)

  _qtbase(ver.qt, paths, info, config.jobs)
