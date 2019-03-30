#!/bin/sh

docker-compose run -w /project/example client digdag init hello-world
docker-compose run -w /project/example client digdag push --project hello-world hello-world -e http://server:65432
docker-compose rm client
