#!/bin/bash

set -e

# ensure existence of release folder
if ! [ -d "./release" ]; then
    mkdir ./release
fi

# ensure zip is installed
if [ "$(which zip)" = "" ]; then
    apt-get update && apt-get install -y zip
fi

# add execution permission
chmod 750 ./build/git-release-linux-amd64
chmod 750 ./build/git-release-windows-4.0-amd64.exe

# create archives
tar -czf ./release/git-release-linux-amd64.tar.gz -C ./build git-release-linux-amd64
zip -j ./release/git-release-windows-4.0-amd64.zip ./build/git-release-windows-4.0-amd64.exe

# # move apple binary
# unzip ./build/wakatime-cli-darwin-10.6-amd64.zip
# chmod 750 ./wakatime-cli-darwin-10.6-amd64
# zip -j ./release/wakatime-cli-darwin-10.6-amd64.zip ./wakatime-cli-darwin-10.6-amd64

# calculate checksums
for file in  ./release/*; do
	checksum=$(sha256sum ${file} | cut -d' ' -f1)
	filename=$(echo ${file} | rev | cut -d/ -f1 | rev)
	echo "${checksum} ${filename}" >> ./release/checksums_sha256.txt
done
