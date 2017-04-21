#!/usr/bin/env bash

set -o pipefail

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for FILE in $(ls "${__DIR}/bash") ; do
    source "${__DIR}/bash/${FILE}"
done

downloadSymfonyDemo
downloadDockerSkeleton
copyFilesFromSkeleton
configureDocroot
configureVersion
copyBuildXml
