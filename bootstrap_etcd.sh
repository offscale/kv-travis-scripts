#!/usr/bin/env bash

set -aeuo pipefail

TRIPLET="$1"'-amd64'
EXT="$2"
ETCD_VERSION="${ETCD_VERSION-3.3.13}"
DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
INSTALL_DIR="${INSTALL_DIR-$HOME/bin/etcd}"
curl -L 'https://github.com/etcd-io/etcd/releases/download/v'"$ETCD_VERSION"'/etcd-v'"$ETCD_VERSION"'-'"${TRIPLET}"'.'"${EXT}" -o "$DOWNLOAD_DIR"'/etcd.'"${EXT}"

mkdir -p "$INSTALL_DIR"
if [[ "$EXT" == "tar.gz" ]]; then
	tar xzf "$DOWNLOAD_DIR"'/etcd.'"${EXT}" -C "$INSTALL_DIR"'/etcd' --strip-components=1
elif [[ "$EXT" == "zip" ]]; then
	unzip "$DOWNLOAD_DIR"'/etcd.'"${EXT}" -d "$INSTALL_DIR"
else
	exit 2
fi

pushd "$INSTALL_DIR"

mkdir '_data'
./etcd --data-dir "$PWD"'/_data' > /dev/null &
