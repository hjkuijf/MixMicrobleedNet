#!/usr/bin/env bash

./build.sh

docker save mixmicrobleednet | gzip -c > mixmicrobleednet.tar.gz
