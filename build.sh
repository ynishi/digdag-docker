#!/bin/sh

VERSION=1.1.0

docker build -t digdag .
docker build -t digdag:$VERSION .
