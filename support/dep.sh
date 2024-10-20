#!/bin/bash

apt update
env DEBIAN_FRONTEND=noninteractive \
  apt install -y --no-install-recommends \
    cmake g++ gcc m4 make meson texinfo \
    libarchive-tools python3 python3-packaging
