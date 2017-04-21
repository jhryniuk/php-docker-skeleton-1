#!/usr/bin/env bash

function downloadSymfonyDemo
{
    if [ ! -d "${DEMO_PATH}" ]; then
        echo -e "${COLOR_START}Symfony-demo downloading..${COLOR_STOP}"
        git clone https://github.com/symfony/symfony-demo.git "${DEMO_PATH}"
    else
        echo -e "${COLOR_START}Symfony-demo${COLOR_STOP} already downloaded"
    fi
}

function downloadDockerSkeleton
{
    if [ ! -d "${SKELETON_PATH}" ]; then
        echo -e "${COLOR_START}Docker-skeleton downloading..${COLOR_STOP}"
        git clone https://github.com/PGSSoft/php-docker-skeleton.git "${SKELETON_PATH}"
    else
        echo -e "${COLOR_START}Docker-skeleton${COLOR_STOP} already downloaded"
    fi
}
