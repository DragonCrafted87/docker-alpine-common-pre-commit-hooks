#!/bin/bash

./build.sh

MSYS_NO_PATHCONV=1 \
    docker run \
        --rm \
        --volume "$(pwd)":/src \
        ghcr.io/dragoncrafted87/alpine-common-pre-commit-hooks
