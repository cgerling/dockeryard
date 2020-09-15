#!/usr/bin/env bash

source "$SCRIPTS_DIR/utils/utils.sh"
source "$SCRIPTS_DIR/utils/docker.sh"

function build_cmd {
  local image_expr=$1
  local build_options=${@:2}

  local registry=$(get_registry)
  local owner=$(get_owner)
  local image_namespace=$(build_image_namespace $registry $owner)

  IFS=' ' read -r image_name image_version <<< "$(parse_image_expr $image_expr)"

  local image_paths=$(get_image_paths $IMAGES_DIR $image_name $image_version)

  for image_path in $image_paths
  do
    image_tag=$(convert_image_path_to_tag $image_path)
    echo "[$image_tag]"

    namespaced_image_tag=$(build_namespaced_image_tag $image_namespace $image_tag)
    docker_build_cmd=$(build_docker_build_cmd $image_path $namespaced_image_tag "$build_options")

    eval "$docker_build_cmd"

    echo -e "\n"
  done
}

build_cmd $@

