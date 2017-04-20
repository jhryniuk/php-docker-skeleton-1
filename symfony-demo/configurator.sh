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

COLOR_START="\033[1;36m"
COLOR_STOP="\033[0m"

function downloadSymfonyDemo
{
    if [ ! -d "${DEMO_PATH}" ]; then
        echo -e "${COLOR_START}Symfony-demo downloading..${COLOR_STOP}"
        git clone git@github.com:symfony/symfony-demo.git "${DEMO_PATH}"
    else
        echo -e "${COLOR_START}Symfony-demo${COLOR_STOP} already donwloaded"
    fi
}

function downloadDockerSkeleton
{
    if [ ! -d "${SKELETON_PATH}" ]; then
        echo -e "${COLOR_START}Docker-skeleton downloading..${COLOR_STOP}"
        git clone git@github.com:PGSSoft/php-docker-skeleton.git "${SKELETON_PATH}"
    else
        echo -e "${COLOR_START}Docker-skeleton${COLOR_STOP} already downloaded"
    fi
}

function copyFilesFromSkeleton
{
    for i in "${SKELETON_FILES[@]}"
    do
        if [ ! -f "${DEMO_PATH}/${i}" ] | [ ! -d "${DEMO_PATH}/${i}" ]; then
            echo -e "Copy ${COLOR_START}${SKELETON_PATH}/${i}${COLOR_STOP} to ${COLOR_START}${DEMO_PATH}/${i}${COLOR_STOP} .."
            cp -r "${SKELETON_PATH}/${i}" "${DEMO_PATH}/${i}"
        else
            echo -e "${COLOR_START}${DEMO_PATH}/${i}${COLOR_STOP} already exists."
        fi
    done
}

function configureDocroot
{
    if grep -q "PROJECT_INDEX_FILE:=\"app.php\"" "${DEMO_PATH}/docker.sh"; then
        echo -e "${COLOR_START}PROJECT_INDEX_FILE:=\"app.php\"${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/docker.sh${COLOR_STOP}"
    else
        echo -e "${COLOR_START}PROJECT_INDEX_FILE:=\"app.php\"${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/docker.sh${COLOR_STOP}"
        sed -i "s/PROJECT_INDEX_FILE:=\"index.php\"/PROJECT_INDEX_FILE:=\"app.php\"/g" "${DEMO_PATH}/docker.sh"
    fi

    if grep -q "PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"" "${DEMO_PATH}/docker.sh"; then
        echo -e "${COLOR_START}PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/docker.sh${COLOR_STOP}"
    else
        echo -e "${COLOR_START}PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/docker.sh${COLOR_STOP}"
        sed -i "s/PROJECT_DEV_INDEX_FILE:=\"index_dev.php\"/PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"/g" "${DEMO_PATH}/docker.sh"
    fi
}

function configureVersion
{
    if grep -q "\"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"; then
        echo -e "${COLOR_START}\"version\": \"${DEMO_VERSION}\",${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/composer.json${COLOR_STOP}"
    else
        echo -e "${COLOR_START}\"version\": \"${DEMO_VERSION}\",${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/composer.json${COLOR_STOP}"
        sed -i "/\"name\": \"symfony\/symfony-demo\",/a \"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"
    fi
}

function copyBuildXml
{
    if [ ! -f "${DEMO_PATH}/build.xml" ]; then
        echo -e "Copy ${COLOR_START}${__dir}/build.xml${COLOR_STOP} to ${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} .."
        cp -r "${__dir}/build.xml" "${DEMO_PATH}/build.xml"
    else
        echo -e "${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} already exists."
    fi
}

downloadSymfonyDemo
downloadDockerSkeleton
copyFilesFromSkeleton
configureDocroot
configureVersion
copyBuildXml
