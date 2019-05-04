#!/bin/bash

set -ex

# Show environment.
uname -a
id
pwd
docker --version
docker info
ls -l tests/foo.txt
cat tests/foo.txt
echo "IMAGE: ${IMAGE}"
docker pull "${IMAGE}"
docker run --rm -t "${IMAGE}" uname -m

# Tests
# Case1: tests/foo.txt appears when building a container on local.
docker build --rm -t sample --build-arg IMAGE=${IMAGE} .
docker run --rm -t sample ls -lR
docker run --rm -t sample cat tests/foo.txt

# Case2: tests/foo.txt does not appears when binding volume from docker command.
docker run --rm -t -w /build -v "$(pwd)/tests:/build/tests" "${IMAGE}" ls -lR
docker run --rm -t -w /build -v "$(pwd)/tests:/build/tests" "${IMAGE}" ls -l tests/foo.txt
docker run --rm -t -w /build -v "$(pwd)/tests:/build/tests" "${IMAGE}" cat tests/foo.txt
