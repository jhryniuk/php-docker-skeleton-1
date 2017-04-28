#!/usr/bin/env bash

function downloadSymfonyDemo
{
    DEMO_PATH=$1
    COLOR_START=$2
    COLOR_STOP=$3

    if [ ! -d "${DEMO_PATH}" ]; then
        echo -e "${COLOR_START}Symfony-demo downloading..${COLOR_STOP}"
        git clone https://github.com/symfony/symfony-demo.git "${DEMO_PATH}"
    else
        echo -e "${COLOR_START}Symfony-demo${COLOR_STOP} already downloaded"
    fi
}

function downloadDockerSkeleton
{
    SKELETON_PATH=$1
    COLOR_START=$2
    COLOR_STOP=$3

    if [ ! -d "${SKELETON_PATH}" ]; then
        echo -e "${COLOR_START}Docker-skeleton downloading..${COLOR_STOP}"
        git clone https://github.com/jhryniuk/php-docker-skeleton.git "${SKELETON_PATH}" -b feature/split-bash
    else
        echo -e "${COLOR_START}Docker-skeleton${COLOR_STOP} already downloaded"
    fi
}
