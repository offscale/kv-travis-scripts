#!/usr/bin/env bash

set -aeuo pipefail

TRIPLET="$1"'-amd64'
EXT="$2"
ETCD_VERSION="${ETCD_VERSION-3.3.13}"
DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
INSTALL_DIR="${INSTALL_DIR-$HOME/bin/etcd}"
ARCHIVE='etcd-v'"$ETCD_VERSION"'-'"${TRIPLET}"'.'"${EXT}"

mkdir -p "$DOWNLOAD_DIR" "$INSTALL_DIR"
curl -L 'https://storage.googleapis.com/etcd/v'"$ETCD_VERSION"'/'"$ARCHIVE" -o "$DOWNLOAD_DIR"'/'"$ARCHIVE"

if [[ "$EXT" == "tar.gz" ]]; then
	tar xzf "$ARCHIVE" -C "$INSTALL_DIR" --strip-components=1
elif [[ "$EXT" == "zip" ]]; then
	unzip "$ARCHIVE" -d "$INSTALL_DIR"
else
	exit 2
fi

pushd "$INSTALL_DIR"
ls -alR

mkdir '_data'
./etcd --data-dir "$PWD"'/_data' > /dev/null &
