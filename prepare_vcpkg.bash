#!/usr/bin/env bash

set -aeuo pipefail

declare -r DIR="$1"
declare -r BOOT_CODE="$2"

if [[ -d "$DIR" ]] && [[ ! -d "$DIR"'/.git' ]]; then
	rm -rf "$DIR"
fi

if [[ ! -d "$DIR" ]]; then
	mkdir -p "$(dirname "$DIR")"
	git clone --depth=20 'https://github.com/Microsoft/vcpkg' "$DIR"
	pushd "$DIR"
	$BOOT_CODE
else
	pushd "$DIR"
	git reset --hard HEAD
	git pull
fi
