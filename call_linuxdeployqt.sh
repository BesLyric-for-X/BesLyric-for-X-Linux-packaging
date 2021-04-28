#!/bin/bash
#
# Perform the dependecies fetching and application packaging.


set -e
set -o pipefail
set -u


# ====== Input variables testing ======
# "set -u" takes effect.
echo "DESKTOP_FILE_PATH = '${DESKTOP_FILE_PATH}'"
echo "OPENSSL_LIB_DIR_PATH = '${OPENSSL_LIB_DIR_PATH}'"
echo "LINUXDEPLOYQT_PATH = '${LINUXDEPLOYQT_PATH}'"
echo "QMAKE_PATH = '${QMAKE_PATH}'"
echo "VERSION = '${VERSION}'"


# ====== Variables preparation ======
echo

# Set openssl lib files path
libssl_lib_file_name='libssl.so.1.1'
libcrypto_lib_file_name='libcrypto.so.1.1'

libssl_lib_file_path="${OPENSSL_LIB_DIR_PATH}/${libssl_lib_file_name}"
libcrypto_lib_file_path="${OPENSSL_LIB_DIR_PATH}/${libcrypto_lib_file_name}"

# lib dir
lib_dir_path="$( dirname ${DESKTOP_FILE_PATH} )/../../lib"  # AppDir/usr/lib


# Copy OpenSSL libs
echo
echo '====== Copying OpenSSL libs ======'

test -d "${lib_dir_path}" || mkdir --verbose "${lib_dir_path}"
cp --verbose "${libssl_lib_file_path}" "${lib_dir_path}"
cp --verbose "${libcrypto_lib_file_path}" "${lib_dir_path}"


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
