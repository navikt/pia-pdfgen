# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.15@sha256:b366764db68f48e37baf98795f39ce2cb852302a7730adbc18f6c6b75ff5a81e

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources