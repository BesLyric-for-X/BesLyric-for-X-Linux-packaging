# BesLyric-for-X Deployment and Packaging Scripts (Linux)

## Introduction

The script(s) in this repository are used to deploy and package BesLyric-for-X on Linux.

## Environment

Ubuntu 16.04

## Dependent libraries

### X protocol C-language Binding (XCB)

Install these packages via `apt-get install` (get the library files list via `ldd plugins/platforms/libqxcb.so` ):

```shell
apt install -y \
    libxcb-dri2-0 \
    libxcb-dri3-0 \
    libxcb-glx0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-present0 \
    libxcb-randr0 \
    libxcb-render0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-shm0 \
    libxcb1 \
    libxcb-sync1 \
    libxcb-util1 \
    libxcb-xfixes0 \
    libxcb-xinerama0 \
    libxcb-xkb1
```

See also [Not all the dependencies are installed. · Issue #88 · jurplel/install-qt-action](https://github.com/jurplel/install-qt-action/issues/88) .

### OpenSSL 1.1.1

Build from [source](https://www.openssl.org/source/) and don't install.

## Dependent tools

These tools are required to complete the work:

- Bash 4
- linuxdeployqt 7 @ `d41e2345694e6d09820df66e5edb6e8c01db9fb9`

## How to use

### Get

```console
$ git clone https://github.com/BesLyric-for-X/BesLyric-for-X_Linux_deploy-package.git
```

### Execute with variables

#### Deployment and packaging

```shell
   DESKTOP_FILE_PATH='path/to/desktop/file/in/AppDir/usr/share/applications' \
OPENSSL_LIB_DIR_PATH='path/to/dir/contains/libcrypto.so.1.1/and/libssl.so.1.1' \
  LINUXDEPLOYQT_PATH='path/to/linuxdeployqt' \
          QMAKE_PATH='path/to/qmake' \
             VERSION='will.be.added.to.AppImage.file.name' \
    bash 'call_linuxdeployqt.sh'
```

## Common code snippets

### Writing Safe Shell Scripts

Source: [Writing Safe Shell Scripts](https://sipb.mit.edu/doc/safe-shell/)

```shell
set -e           # Checking tons of $? is painful
set -o pipefail  # Error will not disappear in the pipeline
set -u           # Detect unbound variables
```

## Credits

Projects:

- [probonopd/linuxdeployqt](https://github.com/probonopd/linuxdeployqt)
