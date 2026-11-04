# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.49@sha256:61845910374e92eefe3e838fd13900d4e043dff1089396ed9c004015f9931cb3

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources