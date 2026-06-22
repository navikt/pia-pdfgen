#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
PDFGENRS_VERSION="1.0.4@sha256:2a66f7c90a084da9931b0aa29beeee58bd4fb5d8f1bb963537a328401fd80853"

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