# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.25@sha256:2c78bd1f13609d63b780c88d4fc12187daf0dcba32028aad1f27643fbad7e34a

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources