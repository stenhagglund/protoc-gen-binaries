#!/bin/sh

cd dist
rm -f sha256.txt
sha256sum $(ls . | grep -v sha256.txt) >> sha256.txt

cd ..
gh release create v28.2 ./dist/* --notes "Binaries built from https://github.com/protocolbuffers/protobuf/releases/tag/v28.2"