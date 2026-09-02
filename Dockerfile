# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.30@sha256:4b685f26981b445b4bde56262900ed35ef70e6ca748fca71dce00552424806dc

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources