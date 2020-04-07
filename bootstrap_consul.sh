#!/usr/bin/env bash

set -aeuo pipefail

TRIPLET="$1"'_amd64'
EXT='zip'
CONSUL_VERSION="${CONSUL_VERSION-1.5.1}"
DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
INSTALL_DIR="${INSTALL_DIR-$HOME/bin/consul}"
curl -L 'https://releases.hashicorp.com/consul/'"$CONSUL_VERSION"'/consul_'"$CONSUL_VERSION"'_'"${TRIPLET}"'.'"${EXT}" -o "$DOWNLOAD_DIR"'/consul.'"${EXT}"

mkdir -p "$INSTALL_DIR"
unzip -q "$DOWNLOAD_DIR"'/consul.'"${EXT}" -d "$INSTALL_DIR"

pushd "$INSTALL_DIR"

./consul agent -dev > /dev/null &
