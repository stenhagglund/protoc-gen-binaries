#!/bin/sh

mkdir -p dist/
mkdir -p build/
cd build/

git clone --depth 1 --branch v28.2 https://github.com/protocolbuffers/protobuf

cd protobuf

git apply ../../patch.diff
bazel build //src/google/protobuf/compiler:protoc-gen-python //src/google/protobuf/compiler:protoc-gen-pyi

cp ./bazel-bin/src/google/protobuf/compiler/protoc-gen-python ../../dist/protoc-gen-python-darwin-arm64 
chmod +x ../../dist/protoc-gen-python-darwin-arm64
cp ./bazel-bin/src/google/protobuf/compiler/protoc-gen-pyi ../../dist/protoc-gen-pyi-darwin-arm64 
chmod +x ../../dist/protoc-gen-pyi-darwin-arm64