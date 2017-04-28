#!/usr/bin/env bash

function copyFilesFromSkeleton
{
    SKELETON_FILES=$1
    DEMO_PATH=$2
    SKELETON_PATH=$3
    COLOR_START=$4
    COLOR_STOP=$5

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

function copyBuildXml
{
    DEMO_PATH=$1
    DIR=$2
    COLOR_START=$3
    COLOR_STOP=$4

    if [ ! -f "${DEMO_PATH}/build.xml" ]; then
        echo -e "Copy ${COLOR_START}${DIR}/build.xml${COLOR_STOP} to ${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} .."
        cp -r "${DIR}/build.xml" "${DEMO_PATH}/build.xml"
    else
        echo -e "${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} already exists."
    fi
}