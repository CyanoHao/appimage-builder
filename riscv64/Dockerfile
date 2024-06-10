FROM docker.io/riscv64/ubuntu:20.04

# System
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends -y \
        # general utils
        ca-certificates curl xz-utils \
        # general devtools
        gcc g++ make \
        # Qt build tools
        file \
        # Qt libs
        libatspi2.0-dev libdbus-1-dev libfontconfig1-dev libfreetype6-dev libgl1-mesa-dev libwayland-dev \
        libx11-xcb-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-xinerama0-dev libxkbcommon-dev libxkbcommon-x11-dev \
        # Red Panda C++
        git \
        # appimage tools
        squashfs-tools && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/qt/bin:${PATH}

ARG QT_MAJOR_MINOR=5.15
ARG QT_PATCH=14
ARG QT_VERSION=${QT_MAJOR_MINOR}.${QT_PATCH}
ARG FCITX5_QT_VERSION=5.1.6

# AppImage runtime
RUN curl -L -o /opt/appimage-runtime 'https://github.com/cyano-linux/appimage-riscv64/releases/download/20230808.0/runtime-riscv64'

# Qt 5
RUN mkdir -p /build/qt5 && \
    cd /build/qt5 && \
    curl -L -O "https://download.qt.io/archive/qt/${QT_MAJOR_MINOR}/${QT_VERSION}/single/qt-everywhere-opensource-src-${QT_VERSION}.tar.xz" && \
    tar xf qt-everywhere-opensource-src-${QT_VERSION}.tar.xz && \
    cd qt-everywhere-src-${QT_VERSION} && \
    ls | grep ^qt | grep -vE 'qt(\.pro|base|svg|tools|wayland|translations)' | xargs rm -r && \
    ./configure \
        -prefix /opt/qt \
        -opensource -confirm-license \
        -optimize-size -static -platform linux-g++ -linker bfd \
        -no-feature-wayland-server \
        -nomake examples -nomake tests -nomake tools -dbus-linked \
        -qt-doubleconversion -no-glib -eventfd -inotify -iconv -no-icu -no-mimetype-database -qt-pcre -qt-zlib -no-zstd \
        -no-openssl \
        -no-cups -fontconfig -system-freetype -qt-harfbuzz -no-gtk -no-opengl -xcb-xlib \
        -xcb \
        -bundled-xcb-xinput \
        -qt-libjpeg -qt-libpng \
        -sql-sqlite -qt-sqlite && \
    make -j$(nproc) && \
    make install && \
    # cleanup
    cd / && \
    rm -r /build/qt5

# fcitx5-qt
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install --no-install-recommends -y \
        cmake extra-cmake-modules && \
    mkdir -p /build/qt5 && \
    cd /build/qt5 && \
    curl -L -o fcitx5-qt-${FCITX5_QT_VERSION}.tar.gz "https://github.com/fcitx/fcitx5-qt/archive/refs/tags/${FCITX5_QT_VERSION}.tar.gz" && \
    tar xf fcitx5-qt-${FCITX5_QT_VERSION}.tar.gz && \
    cd fcitx5-qt-${FCITX5_QT_VERSION} && \
    cmake . -Bbuild -DCMAKE_MODULE_PATH=/opt/qt/lib/cmake -DCMAKE_PREFIX_PATH=/opt/qt -DCMAKE_BUILD_TYPE=Release -DENABLE_QT4=Off -DENABLE_QT5=On -DENABLE_QT6=Off -DBUILD_ONLY_PLUGIN=On -DBUILD_STATIC_PLUGIN=On && \
    cmake --build build --parallel && \
    cmake --install build && \
    # cleanup
    apt autoremove --purge -y \
        cmake extra-cmake-modules && \
    rm -rf /var/lib/apt/lists/* && \
    cd / && \
    rm -r /build/qt5
