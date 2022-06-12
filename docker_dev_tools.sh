#!/bin/bash -e

echo "Please choose mode <build|deploy|template> : "
read MODE

#select mode
case $MODE in

  build)
    echo -n "You are on build mode, please select image-name and image-tag "
    read image-name image-tag
    ;;

  deploy)
    echo -n "You are on deploy mode, please specify image-name and image-tag "
    read image-name image-tag
    echo -n "Would you like to specify container-name and add limitations on memory and cpu? "
    re container_name memory cpu
    ;;
    
  template)
    echo -n "You are on template mode, please specify application-name "
    read image-name image-tag

ARGUMENT_LIST=(
  "image-name"
  "image-tag"
  "registery"
)


# arguments options created
opts=$(getopt \
  --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
  --name "$(basename "$0")" \
  --options "" \
  -- "$@"
)

eval set --$opts

while [[ $# -gt 0 ]]; do
  case "$1" in
    --image-name)
      imageName=$2
      shift 2
      ;;

    --image-tag)
      imageTag=$2
      shift 2
      ;;

    --registery)
      Registery=$2
      shift 2
      ;;

    *)
      break
      ;;
  esac
done

if [ ! -z "${registery}" ]; #build and push the image

then
    docker build -t ${registery}/${imageName}:${imageTag} -t ${registery}/${imageName}:latest .
    docker push ${registery}/${imageName}

else
    docker build -t /${imageName}:${imageTag} -t /${imageName}:latest .

fi





