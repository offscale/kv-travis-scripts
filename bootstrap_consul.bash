#!/usr/bin/env bash

set -aeuo pipefail

declare -r TRIPLET="$1"'_amd64'
declare -r EXT='zip'
declare -r CONSUL_VERSION="${CONSUL_VERSION-1.5.1}"
declare -r DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
declare -r INSTALL_DIR="${INSTALL_DIR-$HOME/bin/consul}"
declare -r ARCHIVE='consul_'"$CONSUL_VERSION"'_'"${TRIPLET}"'.'"${EXT}"

mkdir -p "$DOWNLOAD_DIR" "$INSTALL_DIR"
pushd "$DOWNLOAD_DIR"

[ -s "$ARCHIVE" ] || curl -L 'https://releases.hashicorp.com/consul/'"$CONSUL_VERSION"'/'"$ARCHIVE" -o "$ARCHIVE"
unzip "$ARCHIVE" -d "$INSTALL_DIR"

pushd "$INSTALL_DIR"

./consul agent -dev > /dev/null &
