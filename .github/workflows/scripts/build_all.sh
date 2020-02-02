#!/bin/bash

source "$SCRIPTS_PATH/default_values.sh"

for image in $IMAGES 
do
  printf "[$image] \n"
  eval "$SCRIPT_BUILD $image"
  printf "\n\n"
done
