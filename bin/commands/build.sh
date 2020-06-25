#!/usr/bin/env bash

function build_cmd {
  function get_image_info {
    local image_expr=$1
    local part_name=$2
    IFS=':' read -r image version <<< "$image_expr"

    case "$part_name" in
      'image') echo "$image";;
      'version') echo "$version";;
    esac
  }

  function load_image_metadata {
    local images_dir=$1
    local image_name=$2

    source "$images_dir/$image_name/meta.sh"
  }

  function get_image_version {
    local default_version="latest"
    local version=$1
    local version_metadata=$2

    if [[ -z $version ]]; then
      version=$version_metadata
    fi

    if [[ -z $version ]]; then
      version=$default_version
    fi

    echo "$version"
  }

  function build_image_tag {
    local image=$1
    local version=$2
    local registry=$3
    local owner=$4

    echo "$registry/$owner/$image:$version"
  }

  function build_docker_build_cmd {
    local image_path=$1
    local tag=$2
    local external_args=${@:3}
    local dockerfile="$image_path/Dockerfile"

    local args="--force-rm $external_args"
    local cmd="docker build --tag $tag --file $dockerfile $args $image_path"

    echo "$cmd"
  }

  function run_cmd {
    local image_expr=$1
    local image_name=$(get_image_info $image_expr "image")
    local image_version=$(get_image_info $image_expr "version")

    load_image_metadata $IMAGES_DIR $image_name

    image_version=$(get_image_version $image_version $CURRENT_VERSION)

    local registry="docker.pkg.github.com"
    local owner="cgerling/dockeryard"
    image_tag=$(build_image_tag $image_name $image_version $registry $owner)

    local image_path="$IMAGES_DIR/$image_name"
    local build_args=${@:2}
    eval "$(build_docker_build_cmd $image_path $image_tag $build_args)"
  }

  run_cmd $@
}

build_cmd $@

