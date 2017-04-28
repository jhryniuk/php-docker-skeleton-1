#!/usr/bin/env bash

set -o pipefail

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for FILE in $(ls "${__DIR}/bash") ; do
    source "${__DIR}/bash/${FILE}"
done

setupVariables
downloadSymfonyDemo "${DEMO_PATH}" "${COLOR_START}" "${COLOR_STOP}"
downloadDockerSkeleton "${SKELETON_PATH}" "${COLOR_START}" "${COLOR_STOP}"
copyFilesFromSkeleton "${SKELETON_FILES}" "${DEMO_PATH}" "${SKELETON_PATH}" "${COLOR_START}" "${COLOR_STOP}"
configureDocroot "${DEMO_PATH}" "${COLOR_START}" "${COLOR_STOP}"
configureVersion "${DEMO_PATH}"  "${DEMO_VERSION}" "${__DIR}" "${COLOR_START}" "${COLOR_STOP}"
copyBuildXml "${DEMO_PATH}" "${__DIR}" "${COLOR_START}" "${COLOR_STOP}"
