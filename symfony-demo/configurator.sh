#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEMO_PATH="${__dir}/symfony-demo"
DEMO_VERSION="0.0.1"

SKELETON_PATH="${__dir}/php-docker-skeleton"

SKELETON_FILES=(
    docker
    .project_name
    docker.sh
    docker-compose.local.yml
    docker-compose.yml
)

function downloadSymfonyDemo
{
    if [ ! -d "${DEMO_PATH}" ]; then
        echo -e "\033[1;36mSymfony-demo downloading..\033[0m"
        git clone git@github.com:symfony/symfony-demo.git "${DEMO_PATH}"
    else
        echo -e "\033[1;36mSymfony-demo\033[0m already donwloaded"
    fi
}

function downloadDockerSkeleton
{
    if [ ! -d "${SKELETON_PATH}" ]; then
        echo -e "\033[1;36mDocker-skeleton downloading..\033[0m"
        git clone git@github.com:PGSSoft/php-docker-skeleton.git "${SKELETON_PATH}"
    else
        echo -e "\033[1;36mDocker-skeleton\033[0m already downloaded"
    fi
}

function copyFilesFromSkeleton
{
    for i in "${SKELETON_FILES[@]}"
    do
        if [ ! -f "${DEMO_PATH}/${i}" ] | [ ! -d "${DEMO_PATH}/${i}" ]; then
            echo -e "Copy \033[1;36m${SKELETON_PATH}/${i}\033[0m to \033[1;36m${DEMO_PATH}/${i}\033[0m .."
            cp -r "${SKELETON_PATH}/${i}" "${DEMO_PATH}/${i}"
        else
            echo -e "\033[1;36m${DEMO_PATH}/${i}\033[0m already exists."
        fi
    done
}

function configureDocroot
{
    if grep -q "PROJECT_INDEX_FILE:=\"app.php\"" "${DEMO_PATH}/docker.sh"; then
        echo -e "\033[1;36mPROJECT_INDEX_FILE:=\"app.php\"\033[0m already set in \033[1;36m${DEMO_PATH}/docker.sh\033[0m"
    else
        echo -e "\033[1;36mPROJECT_INDEX_FILE:=\"app.php\"\033[0m set in \033[1;36m${DEMO_PATH}/docker.sh\033[0m"
        sed -i "s/PROJECT_INDEX_FILE:=\"index.php\"/PROJECT_INDEX_FILE:=\"app.php\"/g" "${DEMO_PATH}/docker.sh"
    fi

    if grep -q "PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"" "${DEMO_PATH}/docker.sh"; then
        echo -e "\033[1;36mPROJECT_DEV_INDEX_FILE:=\"app_dev.php\"\033[0m already set in \033[1;36m${DEMO_PATH}/docker.sh\033[0m"
    else
        echo -e "\033[1;36mPROJECT_DEV_INDEX_FILE:=\"app_dev.php\"\033[0m set in \033[1;36m${DEMO_PATH}/docker.sh\033[0m"
        sed -i "s/PROJECT_DEV_INDEX_FILE:=\"index_dev.php\"/PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"/g" "${DEMO_PATH}/docker.sh"
    fi
}

function configureVersion
{
    if grep -q "\"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"; then
        echo -e "\033[1;36m\"version\": \"${DEMO_VERSION}\",\033[0m already set in \033[1;36m${DEMO_PATH}/composer.json\033[0m"
    else
        echo -e "\033[1;36m\"version\": \"${DEMO_VERSION}\",\033[0m set in \033[1;36m${DEMO_PATH}/composer.json\033[0m"
        sed -i "/\"name\": \"symfony\/symfony-demo\",/a \"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"
    fi
}

downloadSymfonyDemo
downloadDockerSkeleton
copyFilesFromSkeleton
configureDocroot
configureVersion
