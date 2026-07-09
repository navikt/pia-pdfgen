#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
PDFGENRS_VERSION="1.0.15@sha256:b366764db68f48e37baf98795f39ce2cb852302a7730adbc18f6c6b75ff5a81e"

docker pull ghcr.io/navikt/pdfgenrs:$PDFGENRS_VERSION
docker run \
        -v $CURRENT_PATH/templates:/app/templates \
        -v $CURRENT_PATH/fonts:/app/fonts \
        -v $CURRENT_PATH/data:/app/data \
        -v $CURRENT_PATH/resources:/app/resources \
        -p 8080:8080 \
        -e DISABLE_PDF_GET=false \
        -e JDK_JAVA_OPTIONS \
        -e DEV_MODE=true \
        -it \
        --rm \
        ghcr.io/navikt/pdfgenrs:$PDFGENRS_VERSION