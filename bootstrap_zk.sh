#!/usr/bin/env bash

set -aeuo pipefail

EXT='tar.gz'
ZK_VERSION="${ZK_VERSION-3.5.5}"
DOWNLOAD_DIR="${DOWNLOAD_DIR-$HOME/Downloads}"
INSTALL_DIR="${INSTALL_DIR-$HOME/bin/zk}"
curl -L 'https://archive.apache.org/dist/zookeeper/zookeeper-'"$ZK_VERSION"'/apache-zookeeper-'"$ZK_VERSION"'-bin.'"${EXT}" -o "$DOWNLOAD_DIR"'/zk.'"${EXT}"

mkdir -p "$INSTALL_DIR"
tar xzf "$DOWNLOAD_DIR"'/zk.'"${EXT}" -C "$INSTALL_DIR" --strip-components=1

pushd "$INSTALL_DIR"

echo "tickTime=2000
dataDir=$HOME/zk/data_
clientPort=2181" > "$HOME"'/zk/conf/zoo.cfg'

bin/zkServer.sh start
