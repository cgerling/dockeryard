#!/usr/bin/env bash

source "$SCRIPTS_DIR/utils/utils.sh"
source "$SCRIPTS_DIR/utils/docker.sh"

function push_cmd {
  local image_expr=$1

  IFS=' ' read -r image_name image_version <<< "$(parse_image_expr $image_expr)"

  load_image_metadata $IMAGES_DIR $image_name

  image_version=$(get_image_version $image_version $CURRENT_VERSION)

  local registry="docker.pkg.github.com"
  local owner="cgerling/dockeryard"
  local image_tag=$(build_image_tag $image_name $image_version $registry $owner)

  local push_args=${@:2}

  eval "$(build_docker_push_cmd $image_tag $push_args)"
}

push_cmd $@
