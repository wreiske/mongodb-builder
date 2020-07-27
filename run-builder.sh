#!/bin/bash
set -e

MONGODB_VERSION='4.2.8'
SRC="mongodb-src-r$MONGODB_VERSION"
TARGET="mongodb-linux-x86_64-${MONGODB_VERSION}"
BIN="$TARGET/bin"

[ ! -d $SRC ] && curl "https://fastdl.mongodb.org/src/$SRC.tar.gz" | tar -xz
mkdir -p $BIN
mv "$SRC/mongo" "$SRC/mongod" $BIN
tar -czf "$TARGET.tgz" $TARGET

set -e
cd /mongodb
pip3 install -r etc/pip/compile-requirements.txt

./buildscripts/scons.py \
  mongod mongo \
  --ssl=off \
  --enable-free-mon=off \
  LINKFLAGS='-static-libstdc++' \
  CC=gcc \
  CXX=g++

strip mongo mongod
