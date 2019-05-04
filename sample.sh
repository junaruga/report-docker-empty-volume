#!/bin/bash

set -ex

# Show environment.
uname -a
id
pwd
docker --version
docker info
cat tests/foo.txt
cat bar.txt
echo "IMAGE: ${IMAGE}"
docker pull "${IMAGE}"
docker run --rm -t "${IMAGE}" uname -m

# Tests
# Case1: bar.txt appears when building a container on local.
docker build --rm -t sample --build-arg IMAGE=${IMAGE} .
docker run --rm -t sample ls -lR
docker run --rm -t sample cat bar.txt

# Case2: bar.txt does not appear when doing docker command with binding volume,
# for only Shippable CI.
docker run --rm -t -w /build -v "$(pwd):/build" "${IMAGE}" ls -lR
docker run --rm -t -w /build -v "$(pwd):/build" "${IMAGE}" ls -l bar.txt
docker run --rm -t -w /build -v "$(pwd):/build" "${IMAGE}" cat bar.txt
