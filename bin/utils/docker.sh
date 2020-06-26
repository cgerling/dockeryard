#!/usr/bin/env bash

function build_docker_build_cmd {
  local image_path=$1
  local tag=$2
  local external_options=$3

  local default_options="--force-rm"

  local dockerfile_path="$image_path/Dockerfile"
  local options="--tag $tag --file $dockerfile_path $external_options"
  echo "$(build_docker_cmd "build" "$options" $image_path "$default_options")"
}

function build_docker_push_cmd {
  local image_tag=$1
  local external_options=$2

  echo "$(build_docker_cmd "push" "$external_options" $image_tag)"
}

function build_docker_cmd {
  local command=$1
  local options=$2
  local arg=$3
  local default_options=$4

  echo "docker $command $default_options $options $arg"
}

