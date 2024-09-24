FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get -qq update && \
    apt-get -qq install -y curl build-essential autoconf libtool pkg-config apt-transport-https gnupg git

RUN curl -fsSL https://github.com/bazelbuild/bazelisk/releases/download/v1.16.0/bazelisk-linux-amd64 -o /usr/bin/bazel && \
    echo '168851e70cf5f95c0e215e7f3aaca5132ffc3c8dd8f585a4157b0be2b53cfe32  /usr/bin/bazel' | sha256sum -c && \
    chmod +x /usr/bin/bazel

RUN git clone --depth 1 --branch v28.2 https://github.com/protocolbuffers/protobuf

WORKDIR /protobuf 

ENV USE_BAZEL_VERSION=7.3.1
ENV CC=gcc
RUN bazel build //:protoc_lib

COPY patch.diff ./
RUN git apply patch.diff
RUN bazel build //src/google/protobuf/compiler:protoc-gen-python //src/google/protobuf/compiler:protoc-gen-pyi

RUN cp ./bazel-bin/src/google/protobuf/compiler/protoc-gen-python /usr/local/bin/protoc-gen-python-linux-amd64 && \
    chmod +x "/usr/local/bin/protoc-gen-python-linux-amd64" && \
    cp ./bazel-bin/src/google/protobuf/compiler/protoc-gen-pyi /usr/local/bin/protoc-gen-pyi-linux-amd64 && \
    chmod +x "/usr/local/bin/protoc-gen-pyi-linux-amd64"

