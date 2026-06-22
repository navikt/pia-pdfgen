# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.4@sha256:2a66f7c90a084da9931b0aa29beeee58bd4fb5d8f1bb963537a328401fd80853

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources