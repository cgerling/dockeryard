#!/usr/bin/env bash

source "$SCRIPTS_DIR/utils/docker.sh"
source "$SCRIPTS_DIR/utils/environment.sh"
source "$SCRIPTS_DIR/utils/image.sh"

function push_cmd {
  local image_expr=$1
  local push_options=${@:2}

  local registry=$(get_registry)
  local owner=$(get_owner)
  local image_namespace=$(build_image_namespace $registry $owner)
  
  IFS=' ' read -r image_name image_version <<< "$(parse_image_expr $image_expr)"

  local image_paths=$(get_image_paths $IMAGES_DIR $image_name $image_version)

  set -e

  for image_path in $image_paths
  do
    image_tag=$(convert_image_path_to_tag $image_path)
    echo "[$image_tag]"

    namespaced_image_tag=$(build_namespaced_image_tag $image_namespace $image_tag)
    docker_push_cmd=$(build_docker_push_cmd $namespaced_image_tag "$push_options")

    eval "$docker_push_cmd"

    echo -e "\n"
  done
}

push_cmd $@
