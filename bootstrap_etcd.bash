#!/usr/bin/env bash

set -xaeuo pipefail

declare -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR"'/shared.bash'

declare -r TRIPLET="$1"'-amd64'
declare -r EXT="$2"
declare -r ETCD_VERSION="${ETCD_VERSION-3.4.13}"
declare -r DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
declare -r INSTALL_DIR="${INSTALL_DIR-$HOME/bin/etcd}"
declare -r ARCHIVE='etcd-v'"$ETCD_VERSION"'-'"${TRIPLET}"'.'"${EXT}"

mkdir -p "$DOWNLOAD_DIR" "$INSTALL_DIR"
pushd "$DOWNLOAD_DIR"
[ -s "$ARCHIVE" ] || curl -L 'https://storage.googleapis.com/etcd/v'"$ETCD_VERSION"'/'"$ARCHIVE" -o "$ARCHIVE"

case "$EXT" in
  'tar.gz')
    tar xzf "$ARCHIVE" -C "$INSTALL_DIR" --strip-components=1
    ;;
  'zip')
    unzip-strip "$ARCHIVE" "$INSTALL_DIR"
    ;;
  *)
    exit 2
    ;;
esac

popd
pushd "$INSTALL_DIR"

mkdir '_data'
env -i DATA_DIR="$PWD"'/_data' ./etcd --data-dir "$DATA_DIR" > /dev/null &
