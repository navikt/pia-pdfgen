# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.23@sha256:13d9363ea775421bda8c3cc7c124c1304af41ef8a10a4fa59452b0bc4d9ba468

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources