#!/usr/bin/env bash

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

function parse_image_expr {
  local image_expr=$1
  IFS=':' read -r name version <<< "$image_expr"

  echo "$name" "$version"
}
