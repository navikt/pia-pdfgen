# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.54@sha256:120986ceb2d0501739360c0bc9b07e93e43504a7fe3e2776981cd489ccd8219a

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources