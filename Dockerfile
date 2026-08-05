# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.21@sha256:601f9088b9f424fbe58363f41188b49b5bc4970e84f3f216636fc07d9f6b87c5

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources