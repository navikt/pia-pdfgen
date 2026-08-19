# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.24@sha256:f51c69dc0453a5787abafe3002d243e0893d4c0061a1adab54ae02ca0f96b6c3

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources