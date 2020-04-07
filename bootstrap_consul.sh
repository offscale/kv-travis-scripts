#!/usr/bin/env bash

set -aeuo pipefail

TRIPLET="$1"'_amd64'
EXT='zip'
CONSUL_VERSION='1.5.1'
curl -L 'https://releases.hashicorp.com/consul/'"$CONSUL_VERSION"'/consul_'"$CONSUL_VERSION"'_'"${TRIPLET}"'.'"${EXT}" -o ~'/consul.'"${EXT}"

mkdir -p ~'/consul'
unzip -q ~'/consul.'"${EXT}" -d ~'/consul'

rm -f ~'/consul.'"${EXT}"
cd ~'/consul'

./consul agent -dev > /dev/null &
