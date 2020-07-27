#!/bin/bash
set -e

MONGODB_VERSION='4.2.8'
SRC="mongodb-src-r$MONGODB_VERSION"
TARGET="mongodb-linux-x86_64-${MONGODB_VERSION}"
BIN="$TARGET/bin"

[ ! -d $SRC ] && curl "https://fastdl.mongodb.org/src/$SRC.tar.gz" | tar -xz
ls -lah "$SRC"
mkdir -p $BIN
mv "$SRC/mongo" "$SRC/mongod" $BIN
tar -czf "$TARGET.tgz" $TARGET

cd /mongodb
apt install -y python3-devel python3-scons
pip3 install -r etc/pip/compile-requirements.txt

./buildscripts/scons.py \
  mongod mongo \
  --ssl=off \
  --enable-free-mon=off \
  LINKFLAGS='-static-libstdc++' \
  CC=gcc \
  CXX=g++

strip mongo mongod
