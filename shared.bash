#!/usr/bin/env bash

set -aeuo pipefail

# From https://superuser.com/a/573624
unzip-strip() {
    local zip="$1"
    local dest="${2:-.}"
    local temp="$(mktemp -d)"
    unzip -d "$temp" "$zip"
    mkdir -p "$dest"
    shopt -s dotglob
    local f=("$temp"/*)
    if (( ${#f[@]} == 1 )) && [[ -d "${f[0]}" ]] ; then
        mv "$temp"/*/* "$dest"
    else
        mv "$temp"/* "$dest"
    fi
    rmdir "$temp"/* "$temp"
    shopt -u dotglob
}
