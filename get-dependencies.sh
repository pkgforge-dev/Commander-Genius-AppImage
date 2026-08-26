#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    sdl2_mixer \
    sdl2_ttf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

echo "Building Commander-Genius..."
echo "---------------------------------------------------------------"
REPO="https://gitlab.com/Dringgstein/Commander-Genius"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./CommanderGenius
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./CommanderGenius
cmake -S ./ -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_COSMOS=YES \
    -DUSE_BOOST=NO

cmake --build build -j$(nproc)
mv -v build/src/CGeniusExe ../AppDir/bin
