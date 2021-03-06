#!/bin/sh

set -x

if [ "$1" = "--help" ]; then
    echo "
    Usage of $0:
        $0 <PREFIX> <VERSION> <SUFFIX>

    Example:
        $0 hedgedoc 0.5.1 alpine
    "
fi

PREFIX=${1:-hedgedoc}
VERSION=${2}
SUFFIX=""
[ "${3}" != "" ] && [ "${3}" != "debian" ] && SUFFIX="${3}" SUFFIX_FULL="-${SUFFIX}"



if [ "$VERSION" != "" ]; then
    docker tag hedgedoc:testing "${PREFIX}:$(echo ${VERSION} | cut -d. -f1)${SUFFIX_FULL}"
    docker tag hedgedoc:testing "${PREFIX}:$(echo ${VERSION} | cut -d. -f1-2)${SUFFIX_FULL}"
    docker tag hedgedoc:testing "${PREFIX}:$(echo ${VERSION} | cut -d. -f1-3)${SUFFIX_FULL}"
    if [ "$SUFFIX" = "" ]; then
        docker tag hedgedoc:testing "$PREFIX:latest"
    else
        docker tag hedgedoc:testing "$PREFIX:${SUFFIX}"
    fi
else
    echo "No version provided. Skipping tagging..."
fi
