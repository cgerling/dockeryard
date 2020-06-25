#!/usr/bin/env bash

source "$SCRIPTS_DIR/utils/utils.sh"
source "$SCRIPTS_DIR/utils/docker.sh"

function build_cmd {
  function run_cmd {
    local image_expr=$1

    IFS=' ' read -r image_name image_version <<< "$(parse_image_expr $image_expr)"

    load_image_metadata $IMAGES_DIR $image_name

    image_version=$(get_image_version $image_version $CURRENT_VERSION)

    local registry="docker.pkg.github.com"
    local owner="cgerling/dockeryard"
    image_tag=$(build_image_tag $image_name $image_version $registry $owner)

    local image_path="$IMAGES_DIR/$image_name"
    local build_options=${@:2}
    eval "$(build_docker_build_cmd $image_path $image_tag "$build_options")"
  }

  run_cmd $@
}

build_cmd $@

