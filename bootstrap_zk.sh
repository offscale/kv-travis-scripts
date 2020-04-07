#!/usr/bin/env bash

set -aeuo pipefail

EXT='tar.gz'
ZK_VERSION="${ZK_VERSION-3.5.5}"
DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
INSTALL_DIR="${INSTALL_DIR-$HOME/bin/zk}"
ARCHIVE='apache-zookeeper-'"$ZK_VERSION"'-bin.'"${EXT}"

mkdir -p "$DOWNLOAD_DIR" "$INSTALL_DIR"
curl -L 'https://archive.apache.org/dist/zookeeper/zookeeper-'"$ZK_VERSION"'/'"$ARCHIVE" -o "$DOWNLOAD_DIR"'/'"$ARCHIVE"
tar xzf "$ARCHIVE" -C "$INSTALL_DIR" --strip-components=1

pushd "$INSTALL_DIR"

ls -alR "$HOME/zk"

echo "tickTime=2000
dataDir=$HOME/zk/data_
clientPort=2181" > "$HOME"'/zk/conf/zoo.cfg'

bin/zkServer.sh start
