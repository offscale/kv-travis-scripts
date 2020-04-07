#!/usr/bin/env bash

set -aeuo pipefail

DIR=$1
BOOT_CODE=$2

if [[ -d "$DIR" ]] && [[ ! -d "$DIR"'/.git' ]]; then
	rm -rf "$DIR"
fi

if [[ ! -d "$DIR" ]]; then
	mkdir -p $(dirname "$DIR")
	git clone 'https://github.com/Microsoft/vcpkg' --depth=20 "$DIR"
	pushd "$DIR"
	$BOOT_CODE
else
	cd "$DIR"
	git reset --hard HEAD
	git pull
fi
