#!/usr/bin/env bash

function configureDocroot
{
    DEMO_PATH=$1
    COLOR_START=$2
    COLOR_STOP=$3

    if grep -q "PROJECT_INDEX_FILE:=\"app.php\"" "${DEMO_PATH}/bash/defineVariables.sh"; then
        echo -e "${COLOR_START}PROJECT_INDEX_FILE:=\"app.php\"${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/bash/defineVariables.sh${COLOR_STOP}"
    else
        echo -e "${COLOR_START}PROJECT_INDEX_FILE:=\"app.php\"${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/bash/defineVariables.sh${COLOR_STOP}"
        sed -i "s/PROJECT_INDEX_FILE:=\"index.php\"/PROJECT_INDEX_FILE:=\"app.php\"/g" "${DEMO_PATH}/bash/defineVariables.sh"
    fi

    if grep -q "PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"" "${DEMO_PATH}/bash/defineVariables.sh"; then
        echo -e "${COLOR_START}PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/bash/defineVariables.sh${COLOR_STOP}"
    else
        echo -e "${COLOR_START}PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/bash/defineVariables.sh${COLOR_STOP}"
        sed -i "s/PROJECT_DEV_INDEX_FILE:=\"index_dev.php\"/PROJECT_DEV_INDEX_FILE:=\"app_dev.php\"/g" "${DEMO_PATH}/bash/defineVariables.sh"
    fi
}

function configureVersion
{
    DEMO_PATH=$1
    DEMO_VERSION=$2
    COLOR_START=$3
    COLOR_STOP=$4

    if grep -q "\"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"; then
        echo -e "${COLOR_START}\"version\": \"${DEMO_VERSION}\",${COLOR_STOP} already set in ${COLOR_START}${DEMO_PATH}/composer.json${COLOR_STOP}"
    else
        echo -e "${COLOR_START}\"version\": \"${DEMO_VERSION}\",${COLOR_STOP} set in ${COLOR_START}${DEMO_PATH}/composer.json${COLOR_STOP}"
        sed -i "/\"name\": \"symfony\/symfony-demo\",/a \"version\": \"${DEMO_VERSION}\"," "${DEMO_PATH}/composer.json"
    fi
}