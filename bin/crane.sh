#!/usr/bin/env bash

export SCRIPTS_DIR=$(dirname $(realpath "$0"))
export ROOT_DIR=$(realpath "$SCRIPTS_DIR/..")
export IMAGES_DIR="$ROOT_DIR/images"

function find_cmd_file {
  local commands_dir="$SCRIPTS_DIR/commands"
  local cmd_name=$1

  case "$cmd_name" in
    *) echo "";;
  esac
}

function crane_cmd {
  local cmd=$1
  local cmd_file=$(find_cmd_file $cmd)

  local cmd_args=${@:2}

  if [ -n "$cmd_file" ] && [ -x "$cmd_file" ]; then
    exec "$cmd_file" "$cmd_args"
  else
    echo "crane: '$cmd' is not a command."
    echo "Use 'crane --help' to see all commands."
  fi
}

crane_cmd $@

