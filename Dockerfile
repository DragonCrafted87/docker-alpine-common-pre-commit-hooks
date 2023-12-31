# syntax=docker/dockerfile:1
FROM ghcr.io/dragoncrafted87/alpine:3.19

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Alpine pre-commit-hooks" \
      org.label-schema.description="Alpine Image with pre setup pre-commit settings." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-common-pre-commit-hooks" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN ash <<eot
    set -e

    apk add --no-cache --update \
        bash \
        git \
        nodejs \
        npm \

    pip3 --no-cache-dir \
        install \
            --break-system-packages \
            pre-commit \

    rm -rf /tmp/*
    rm -rf /var/cache/apk/*
eot

COPY root/. /

RUN bash <<eot
    set -e

    chmod +x -R /scripts/*

    pushd /pre-commit || exit 1
    git init --initial-branch main
    pre-commit install --color always --install-hooks --config pre-commit-config.yaml
eot

ENV TZ=America/Chicago
ENV YAMLLINT_CONFIG_FILE=/pre-commit/yamllint.yaml
ENV PYLINTRC=/pre-commit/pylintrc
