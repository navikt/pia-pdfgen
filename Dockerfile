# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.57@sha256:39b5d38c7625d2886e0c98148103aa771ace8f49f9757233e8a4539ad0ca050c

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources