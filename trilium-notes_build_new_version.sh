#!/bin/bash

docker_user="thehotery"
target_arch="linux/arm/v7,linux/arm64,amd64"

printf "Finding latest release number \t"
ver_num=$(curl -s https://api.github.com/repos/zadam/trilium/releases/latest |  grep -oP '(?<=tag_name\":\ \"v)([0-9]{1,4}\.){1,3}[0-9]{1,4}')
#ver_num="0.45.10"
echo ": ${ver_num}"
echo "Downloading latest release"
wget -q "https://github.com/zadam/trilium/archive/v${ver_num}.tar.gz" | exit 1

echo "Extract from archive"
tar xf "v${ver_num}.tar.gz"; cd "trilium-${ver_num}"
[ -f "Dockerfile" ] && echo "extracted files seems like okay, continue..."

echo "Remove -electron- lines from server-package.json"
cat package.json | grep -v electron > server-package.json

echo "Starting docker"

## dont know exacltly what I'm doing
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3

## time to build
echo "building for arch $target_arch"
docker buildx build --platform "${target_arch}" --push -t ${docker_user}/trilium:${ver_num} -t ${docker_user}/trilium:latest .
