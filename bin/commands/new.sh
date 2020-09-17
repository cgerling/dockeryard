#!/usr/bin/env bash

function new_cmd {
  function create_image_workflow {
    local image_name=$1
    local template_file=$2
    local workflow_file=$3

    local template_placeholder="workflow_template"
    cat "$template_file" | sed "s/$template_placeholder/$image_name/g" > "$workflow_file"

    echo "$workflow_file"
  }

  function create_image_dir {
    local dir=$1
    local image_name=$2

    local image_dir="$dir/$image_name"
    mkdir "$image_dir"

    echo "$image_dir"
  }

  function create_image_version_dir {
    local dir=$1
    local version=$2

    if [[ -z "$version" ]]; then
      version="latest"
    fi

    local image_dir="$dir/$version"
    local dockerfile_path="$image_dir/Dockerfile"

    mkdir "$image_dir"
    touch "$dockerfile_path"
    
    echo "$dockerfile_path"
  }

  function run_cmd {
    local name=$1
    local version=$2
    local image_name=$(echo $name | tr '[:upper:]' '[:lower:]')

    local image_dir=$(create_image_dir $IMAGES_DIR $image_name)
    create_image_version_dir $image_dir $version > /dev/null

    local template_file="$SCRIPTS_DIR/private/workflow_template.yml"
    local workflow_file="$WORKFLOWS_DIR/$image_name.yml"
    create_image_workflow $image_name $template_file $workflow_file > /dev/null

    echo "[$image_name] structure created at '$image_dir'"
    echo "workflow $workflow_file"
  }

  run_cmd $@
}

new_cmd $@
