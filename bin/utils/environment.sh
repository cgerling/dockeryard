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


