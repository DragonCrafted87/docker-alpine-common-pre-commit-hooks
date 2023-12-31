#!/usr/bin/env bash

cd "$(git rev-parse --show-toplevel)" || exit 1

NAME=$(basename "$(git rev-parse --show-toplevel)")-pre-commit

MSYS_NO_PATHCONV=1 \
    docker run \
        --rm \
        --name "$NAME" \
        --volume "$(pwd)":/src \
        ghcr.io/dragoncrafted87/alpine-common-pre-commit-hooks \
        "${ARGS[@]}"
