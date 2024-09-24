#!/bin/sh

mkdir -p dist/

docker build --platform=linux/amd64 -t protoc-gen-binaries .
docker container rm protoc-gen-binaries > /dev/null
docker run --name protoc-gen-binaries protoc-gen-binaries /bin/true
docker cp protoc-gen-binaries:/usr/local/bin/protoc-gen-python-linux-amd64 ./dist/protoc-gen-python-linux-amd64
docker cp protoc-gen-binaries:/usr/local/bin/protoc-gen-pyi-linux-amd64 ./dist/protoc-gen-pyi-linux-amd64