#!/usr/bin/env bash

function get_registry {
  local DEFAULT_REGISTRY="docker.pkg.github.com"

  local registry=$CRANE_REGISTRY
  if [[ -z "$registry" ]]; then
    registry=$DEFAULT_REGISTRY
  fi

  echo "$registry"
}

function get_owner {
  local DEFAULT_OWNER="cgerling/dockeryard"

  local owner=$CRANE_OWNER
  if [[ -z "$owner" ]]; then
    owner=$DEFAULT_OWNER
  fi

  echo "$owner"
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

function build_namespaced_image_tag {
  local namespace=$1
  local image_tag=$2

  echo "$namespace/$image_tag"
}

function build_image_tag {
  local image=$1
  local version=$2

  echo "$image:$version"
}

function build_image_namespace {
  local registry=$1
  local owner=$2

  echo "$registry/$owner"
}

function parse_image_expr {
  local image_expr=$1
  IFS=':' read -r name version <<< "$image_expr"

  echo "$name" "$version"
}

function get_image_paths {
  local base_dir=$1
  local image_name=$2
  local image_version=$3

  local image_path="$base_dir/$image_name/*"
  echo `ls -d1 $image_path | grep "$image_version"`
}

function convert_image_path_to_tag {
  local image_path=$1

  IFS='/' read -r -a path_elems <<< "$image_path"

  local path_elems_length=${#path_elems[@]}
  local image_name="${path_elems[$path_elems_length-2]}"
  local image_tag="${path_elems[$path_elems_length-1]}"

  echo "$(build_image_tag $image_name $image_tag)"
}

