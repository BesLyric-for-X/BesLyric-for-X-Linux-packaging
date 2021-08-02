# BesLyric-for-X Deployment and Packaging Scripts (Linux)

## Introduction

The script(s) in this repository are used to deploy and package BesLyric-for-X on Linux.

## Environment

Ubuntu 18.04.5

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

## Dependent tools

These tools are required to complete the work:

- Bash 4
- linuxdeployqt 7 @ `b4697483c98120007019c3456914cfd1dba58384`

## How to use

### Get

```console
$ git clone https://github.com/BesLyric-for-X/BesLyric-for-X_Linux_deploy-package.git
```

### Execute with variables

#### Deployment and packaging

```shell
   DESKTOP_FILE_PATH='path/to/desktop/file/in/AppDir/usr/share/applications' \
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

## Q&A

### Why don't we need to manually copy the library files of OpenSSL 1.1.1?

We have the following dependency relationships:

```console
$ apt-cache depends ffmpeg
ffmpeg
  ...
  Depends: libavformat58
  ...

$ apt-cache depends libavformat58
libavformat58
  ...
  Depends: librabbitmq4
  ...

$ apt-cache depends librabbitmq4
librabbitmq4
  ...
  Depends: libssl1.1
```

And the "libssl1.1" package contains the library files of version 1.1.1:

```console
$ apt-cache show libssl1.1
Package: libssl1.1
...
Version: 1.1.1-1ubuntu2.1~18.04.9
...

$ dpkg -L libssl1.1
...
/usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
/usr/lib/x86_64-linux-gnu/libssl.so.1.1
...
```

Hence, linuxdeployqt will deploy them into "AppDir/usr/lib".

## Credits

Projects:

- [probonopd/linuxdeployqt](https://github.com/probonopd/linuxdeployqt)
