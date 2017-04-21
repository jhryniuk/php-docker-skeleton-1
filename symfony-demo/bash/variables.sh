#!/usr/bin/env bash

DEMO_PATH="${__DIR}/symfony-demo"
DEMO_VERSION="0.0.1"

SKELETON_PATH="${__DIR}/php-docker-skeleton"

SKELETON_FILES=(
    docker
    .project_name
    docker.sh
    docker-compose.local.yml
    docker-compose.yml
)

COLOR_START="\033[1;36m"
COLOR_STOP="\033[0m"