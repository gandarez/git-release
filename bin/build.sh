#!/bin/bash

set -e

if [ -z "$GO_VERSION" ]; then
    echo "Environment GO_VERSION unset"
    exit 1
fi

# build darwin/amd64
docker run --rm \
    -v /home/runner/work/git-release/git-release/build:/build \
    -v /tmp/xgo-cache:/deps-cache:ro \
    -e FLAG_V=false \
    -e FLAG_X=false \
    -e FLAG_RACE=false \
    -e FLAG_BUILDMODE=default \
    -e TARGETS=darwin-10.6/amd64 \
    -e GO111MODULE=on \
    -v /home/runner/work/git-release/git-release:/source \
    ghcr.io/crazy-max/xgo:${GO_VERSION} .

# build linux/amd64
docker run --rm \
    -v /home/runner/work/git-release/git-release/build:/build \
    -v /tmp/xgo-cache:/deps-cache:ro \
    -e FLAG_V=false \
    -e FLAG_X=false \
    -e FLAG_RACE=false \
    -e FLAG_BUILDMODE=default \
    -e TARGETS=linux/amd64 \
    -e GO111MODULE=on \
    -v /home/runner/work/git-release/git-release:/source \
    ghcr.io/crazy-max/xgo:${GO_VERSION} .

# build windows/amd64
docker run --rm \
    -v /home/runner/work/git-release/git-release/build:/build \
    -v /tmp/xgo-cache:/deps-cache:ro \
    -e FLAG_V=false \
    -e FLAG_X=false \
    -e FLAG_RACE=false \
    -e FLAG_BUILDMODE=default \
    -e TARGETS=windows/amd64 \
    -e GO111MODULE=on \
    -v /home/runner/work/git-release/git-release:/source \
    ghcr.io/crazy-max/xgo:${GO_VERSION} .

# print built binaries
tree ./build
