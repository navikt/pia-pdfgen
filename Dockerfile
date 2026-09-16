# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.36@sha256:8a1678d1a0279921620f998f20748e9be2c286585fc50e3e2f838fe451206db7

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources