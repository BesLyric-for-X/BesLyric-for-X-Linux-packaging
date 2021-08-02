#!/bin/bash
#
# Perform the dependecies fetching and application packaging.


set -e
set -o pipefail
set -u


# ====== Input variables testing ======
# "set -u" takes effect.
echo "DESKTOP_FILE_PATH = '${DESKTOP_FILE_PATH}'"
echo "LINUXDEPLOYQT_PATH = '${LINUXDEPLOYQT_PATH}'"
echo "QMAKE_PATH = '${QMAKE_PATH}'"
echo "VERSION = '${VERSION}'"


# Call linuxdeployqt
echo
echo '====== Calling linuxdeployqt ======'

VERSION="${VERSION}" \
    "${LINUXDEPLOYQT_PATH}" "${DESKTOP_FILE_PATH}" \
        -always-overwrite \
        -appimage \
        -no-translations \
        -qmake="${QMAKE_PATH}" \
        -verbose=3
