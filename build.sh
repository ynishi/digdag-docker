#!/bin/sh

VERSION=1.2.0

docker build -t digdag .
docker build -t digdag:$VERSION .
