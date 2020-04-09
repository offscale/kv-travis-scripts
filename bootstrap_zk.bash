#!/usr/bin/env bash

set -aeuo pipefail

declare -r EXT='tar.gz'
declare -r ZK_VERSION="${ZK_VERSION-3.5.5}"
declare -r DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
declare -r INSTALL_DIR="${INSTALL_DIR-$HOME/bin/zk}"
declare -r ARCHIVE='apache-zookeeper-'"$ZK_VERSION"'-bin.'"${EXT}"

mkdir -p "$DOWNLOAD_DIR" "$INSTALL_DIR"
pushd "$DOWNLOAD_DIR"

[ -s "$ARCHIVE" ] || curl -L 'https://archive.apache.org/dist/zookeeper/zookeeper-'"$ZK_VERSION"'/'"$ARCHIVE" -o "$ARCHIVE"
tar xzf "$ARCHIVE" -C "$INSTALL_DIR" --strip-components=1

popd
pushd "$INSTALL_DIR"

echo "tickTime=2000
dataDir=$INSTALL_DIR/data_
clientPort=2181" > "$INSTALL_DIR"'/conf/zoo.cfg'

bin/zkServer.sh start
