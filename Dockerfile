# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.39@sha256:24f6a73234c89d20a899b0121318baa12e185ad47e5e111460625ce1d4ba5f86

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources