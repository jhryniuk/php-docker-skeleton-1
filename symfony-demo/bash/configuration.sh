#!/usr/bin/env bash

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