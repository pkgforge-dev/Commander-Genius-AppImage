#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://gitlab.com/Dringgstein/Commander-Genius/-/raw/master/share/cg.svg?ref_type=heads
export DESKTOP=https://gitlab.com/Dringgstein/Commander-Genius/-/raw/master/share/cgenius.desktop?ref_type=heads
export STARTUPWMCLASS=CGeniusExe
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/CGeniusExe

# Turn AppDir into AppImage
quick-sharun --make-appimage
