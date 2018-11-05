#! /bin/bash

##--- used to remove containers and images that are no longer needed so that space is reacquired

echo "********************************"
echo "* $(date) *"
echo "********************************"

echo "Removing containers"
docker rm $(docker ps -a -q --filter "status=created" --filter "status=exited" --filter "status=dead")

echo "Removing images"
docker rmi $(docker images --filter "dangling=true" -q)
