# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.44@sha256:c178addb125614e0a430fcf40da902e91c8e40fd011d25b7e3df979952234906

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources