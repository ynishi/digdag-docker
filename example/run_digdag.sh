#!/bin/sh

cd $(dirname $0)
echo output is in project, tmp
mkdir -p tmp
chmod 777 tmp
mkdir -p project 
chmod 777 project

if [ "$1" = run ]; then
  out='-o /tmp'
fi
docker run --rm -it -v $(pwd)/project:/project -w /project -v $(pwd)/tmp:/tmp digdag digdag $@ $out 
