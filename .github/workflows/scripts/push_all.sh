#!/bin/bash

source "$SCRIPTS_PATH/default_values.sh"

DOCKER_IMAGES=`docker images --filter "reference=docker.pkg.github.com/cgerling/dockeryard/*" --format "{{.Repository}}:{{.Tag}}"`

for image in $DOCKER_IMAGES
do
  printf "[$image] \n"
  eval "docker push $image"
  printf "\n\n"
done
