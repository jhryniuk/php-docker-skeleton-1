#!/usr/bin/env bash

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

function copyBuildXml
{
    if [ ! -f "${DEMO_PATH}/build.xml" ]; then
        echo -e "Copy ${COLOR_START}${__DIR}/build.xml${COLOR_STOP} to ${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} .."
        cp -r "${__DIR}/build.xml" "${DEMO_PATH}/build.xml"
    else
        echo -e "${COLOR_START}${DEMO_PATH}/build.xml${COLOR_STOP} already exists."
    fi
}