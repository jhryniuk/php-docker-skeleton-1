#!/usr/bin/env bash

DEMO_PATH="symfony-demo"
SKELETON_PATH="php-docker-skeleton"
SKELETON_FILES=(
"docker"
".project_name"
"docker.sh"
"docker-compose.local.yml"
"docker-compose.yml"
)
DEMO_VERSION="0.0.1"

function download-symfony-demo
{
    git clone git@github.com:symfony/symfony-demo.git "${DEMO_PATH}"
}

function download-docker-skeleton
{
    git clone git@github.com:PGSSoft/php-docker-skeleton.git "${SKELETON_PATH}"
}

function copy-files-from-skeleton
{
    for i in "${SKELETON_FILES[@]}"
    do
        cp -r "${SKELETON_PATH}"/"${i}" "${DEMO_PATH}"/"${i}"
    done
}

function configure-docroot
{
    sed -i "s/PROJECT_INDEX_FILE:=\"index.php\"/PROJECT_INDEX_FILE:=\"app.php\"/g" "${DEMO_PATH}"/docker.sh
    sed -i "s/PROJECT_DEV_INDEX_FILE:=\"index_dev.php\"/PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"/g" "${DEMO_PATH}"/docker.sh
}

function configure-version
{
    sed -i "/\"name\": \"symfony\/symfony-demo\",/a \"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}"/composer.json
}

download-symfony-demo
download-docker-skeleton
copy-files-from-skeleton
configure-docroot
configure-version
